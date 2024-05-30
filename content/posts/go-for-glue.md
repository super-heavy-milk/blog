---
title: "Go for glue"
date: "2024-05-23T14:03:23-04:00"
slug: "2024-05-23-go-for-glue"
summary: "I've been thinking that Go might be a good fit for devops scripting."
draft: false
categories:
  - programming
tags:
  - go
  - devops
---

I've been keeping an eye on Go for a couple of years now. It _appears_ to solve two problems at the language level that I run into quite frequently.

1. asynchronous, network-dependent code
1. distribution

## Async

Network code is everywhere, and not just in serving web content to end users.

- polling an endpoint to monitor a long-running job
- checking build status on a CI/CD server
- diffing the state of a Git branch via the GitHub API
- updating a Jira ticket
- auto-generating a Confluence page
- updating a Teams channel via a hook
- etc

Basically any kind of meaningful automation is doing operations over the wire. I've experienced a lot frustration trying to write asynchronous, network-dependent code in Java, Javascript, Python in a "scripting/automation" context. I think the reason is that they are just not well suited for it.

> _Note: no one, including me, is using Java to script things. Try figuring out the best way to making a non-blocking HTTP call from within a Spring request context though._

Java is actually well equipped to deal with concurrency via threads. Of course, because it's Java, this manages to also be a problem. There are simply too many ways to go about doing async operations. Also, in order to use threads, you have to understand the whole history of threads in Java. There is a [400+ page book from 2006](https://www.oreilly.com/library/view/java-concurrency-in/0321349601/) that is still useful because to really get it, you have to go back pretty far.

> _In Java's defense, concurrent programming is just inherently complex. Concurrent code in Java can be complex, but it also gives you a lot of tools._

Python and Javascript have a slightly different (but related) issue, which is the ["what color is your function"](https://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/) problem. If you don't want to read the linked article, the _tldr_ is that mixing async and non-async functions is headache.

Go _seems_ to solve this quite neatly. The standard library is touted to have all the network packages you need for 99% of tasks. Because the standard library is well equipped, dependencies can be kept to a minimum. No colored functions or heavy OS threads, just green threads via goroutines.

> _Practically speaking, this means that any function can be used in a linear, single-threaded fashion or in a concurrent, asynchronous context._

Add in the [errors are values](https://go.dev/blog/errors-are-values) paradigm and Go really starts to look appealing.

## Distribution

Distribution is not that big of an issue if you're just writing dockerized services that deploy to some sort of platform/orchestrator. But, have you ever tried writing a Python cli tool and distributing it to your colleagues? I have. I wouldn't do it again, even though I love writing small projects in Python.

All three of the aforementioned languages suffer from a similar problem - a reliance on a local runtime and local packages. Bash, another language I enjoy hacking small scripts in, has the same problem.

Additionally, it's not just cli tools that can be a problem. At a previous job, we had thousands of lines of Jenkins job scripts written in Jenkins-flavored Groovy. Guess what happened when the org decided to move to GitHub Actions?

> _Yup, all those scripts had to be backported into bash-in-yaml._

What is maddening about the whole thing is that all the code could have been simplified into the classic Unix-y structure:

1. Take some input from standard in, or read some environment variables.
1. Do something.
1. Log to standard err.
1. Write data for the next thing to consume to standard out.
1. Exit.

Had we written those scripts in an actual programming language _(you know, with tests, and versioned dependencies)_, then it might not have been the enormous slice of tech debt that it turned into.

Even better, if the scripts had been written in Go, then they could have just been static binaries. No system dependencies, no runtime. Just curl the tarball, hit it with a little `tar xzf` _"e[x]tract zee file"_ and you're good to go.

## What's the catch?

The catch is that Go is not a scripting language. It's verbose, and highly imperative.

For example, here's some code to filter a list of objects in both Javascript and Go.

**Javascript**

```javascript
const data = [
  { a: [1, 2, 3], b: [4, 5, 6] },
  { c: [7, 8, 9], d: [10, 11, 12] },
  { e: [11, 12, 13], f: [4, 5, 6] },
];

const threshold = 6;
const underThresholdInclusive = data.filter((obj) =>
  Object.values(obj)
    .flat()
    .every((value) => value <= threshold),
);

console.log(underThresholdInclusive); // [{a:[1, 2, 3], b:[4, 5, 6]}]
```

**Go**

```go
package main

import "fmt"

func main() {
	data := []map[string][]int{
		{"a": {1, 2, 3}, "b": {4, 5, 6}},
		{"c": {7, 8, 9}, "d": {10, 11, 12}},
		{"e": {11, 12, 13}, "f": {4, 5, 6}},
	}
	threshold := 6
	var underThresholdInclusive []map[string][]int

	for _, m := range data {
		include := true
		for _, sublist := range m {
			for _, v := range sublist {
				if v > threshold {
					include = false
					break
				}
			}
			if !include {
				break
			}
		}
		if include {
			underThresholdInclusive = append(underThresholdInclusive, m)
		}
	}

	fmt.Println(underThresholdInclusive) // [map[a:[1 2 3] b:[4 5 6]]]
}
```

This is definitely going to fall in the realm of personal preference as to which one you prefer, but the Javascript version is much more succinct.

Also, I don't think the example I've provided is especially contrived. Much of the work in a network-bound scripting context is going to be iterating over JSON responses. It's a bit of a pick-your-battle situation at the end of the day.
