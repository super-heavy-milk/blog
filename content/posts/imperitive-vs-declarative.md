---
title: "Imperative vs Declarative"
date: 2024-01-16T10:51:08-04:00
slug: 2024-01-16-imperative-vs-declarative
type: posts
summary: "Try to be declarative if possible."
draft: false
categories:
  - programming
tags:
  - java
---

Short post today, simple premise:

> _Try to be declarative if possible._

Small aside:

> One of the reasons I started writing about programming is that most of the tech blogs I enjoy tend to provide examples in "cool" languages - Rust, Go, Lisp, etc.
>
> However, most of us are stuck writing in Enterprise Approved™ languages, so I thought it would be neat to write about the mostly uncool languages I'm familiar with _\*cough Java\*_.

Anyways, here is what I mean by imperative vs declarative.

Objective:

1. Find a name in a list.
1. Print it, if it exists.

We're going to try two different styles to achieve this. Which one do you prefer?

```java
import java.util.List;
import java.util.stream.*;

public class Demo {

  public static void main(String[] args) {
    var names = List.of(
      "Bob Yancy",
      "Tyler Lawton",
      "Nancy McSweeny",
      "Karl Plunk"
    );

    /* Imperative */
    var name = "";
    for (String s : names) {
      if (s.contains("Tyler")) {
        name = s;
      }
    }

    if (!name.isEmpty()) {
      System.out.println(name);
    }

    /* Declarative */
    names
      .stream()
      .filter(str -> str.contains("Tyler"))
      .findFirst()
      .ifPresent(System.out::println);
  }
}

```

The declarative style wins for me.

- The chain of operations reads almost like English.
- The intent, which is to _print something if it's found_, is fully encapsulated.
- No intermediate variables, no scope change, no mutation.

The imperative style is also readable, but it's clunky.

- I have to instantiate an intermediate variable, `name`.
- I have to track the mutation of the `name` variable.
- The intent, which is to _print something if it's found_, is not encapsulated - it's spread across several scopes.

This may seem like a trite example, but that's kind of the point.

It's an _easy, quick win_ to write code in the declarative style if you have the option, and it compounds into a net benefit in a larger codebase.
