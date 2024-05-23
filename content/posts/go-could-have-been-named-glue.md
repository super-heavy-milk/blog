---
title: "Go could have been named Glue"
date: "2024-05-23T14:03:23-04:00"
slug: "2024-05-23-go-could-have-been-named-glue"
summary: "Or, scheming about other languages I don't know is easier than dealing with problems in the ones I do."
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

I'm hoping to actually get to use it in anger at some point for work, so that I can test my hypothesis that it's a nice fit for writing glue code.

## Async

I've experienced a lot frustration trying to write asynchronous, network-dependent code in Java, Javascript and Python.

Java is actually well equipped to deal with this sort of thing. Of course, because it's Java, this manages to be a problem. There are simply too many ways to go about solving the async problem, and when you combine the array of choices with Spring, you start to get into max pain territory.

Python and Javascript have a slightly different (but related) issue, which is the ["what color is your function"](https://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/) problem. If you don't want to read the linked article, the tldr is that mixing async and non-async functions is headache.

Go _seems_ to solve this quite neatly. The standard lib has all the network stuff you need for 99% of tasks with no dependencies. No colored functions or heavy OS threads, just green threads in the form of goroutines.

## Distribution

Distribution is not that big of an issue if you're just writing dockerized services that deploy to some sort of platform/orchestrator. But, have you ever tried writing a Python cli tool and distributing it to your coworkers? I have. I wouldn't do it again, even though I love writing small projects in Python.

All three of the aforementioned languages suffer from a similar problem - a reliance on a local runtime and local packages. Bash, another language I enjoy hacking small scripts in, has the same problem.

Additionally, it's not just cute little cli tools that can be a problem.

At my last job, we had thousands of lines of Jenkins job scripts written in Jenkins-flavored Groovy. Guess what happened when the org decided to move to GitHub Actions? Yup, all those scripts now had to be backported into, _shudder_, bash-in-yaml. What is maddening about the whole thing, is all the code really could have been simplified along the following structure.

1. Maybe take some input from standard in, or read some environment variables.
1. Do something.
1. Log to standard err.
1. Maybe write to standard out.
1. Exit.

Had we written those scripts in an actual programming language (you know, with tests, and versioned dependencies), then it might not have been the enormous slice of tech debt that it turned into.

Even better, if the scripts had been written in Go, then they could have just been static binaries. No system dependencies, no runtime, just curl the tarball. Hit it with a little `tar xzf` _"e[x]tract zee file"_ and you're good to go. That binary can be dropped onto a Jenkins server or invoked from a GitHub Action.
