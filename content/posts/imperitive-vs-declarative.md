---
title: 'Imperative vs Declarative'
date: 2024-03-16T10:51:08-04:00
slug: 2024-03-16-imperative-vs-declarative
type: posts
draft: true
categories:
  - programming
tags:
  - java
---

Short post today, simple premise:

> _Try to be declarative if possible._

Small aside:

> One of the reasons I started writing about programming is that most of the tech blogs I enjoy tend to provide examples in "cool" languages - Rust, Go, Lisp, etc. However, most of us are stuck writing in Enterprise Approved™ languages, so I thought it would be neat to write about the mostly uncool languages I'm familiar with _\*cough Java\*_.

Anyways, here what I mean by declarative:

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

    /*
      Our goal today is to: 
        - Find a name in a list 
        - Print it if it exists

      Let's try two different styles to achieve this.
        - Which one do you prefer?
    */

    // Imperative
    var name = "";
    for (String s : names) {
      if (s.contains("Tyler")) {
        name = s;
      }
    }

    if (!name.isEmpty()) {
      System.out.println(name); // "Tyler Lawton"
    }

    // Declarative
    names
      .stream()
      .filter(str -> str.contains("Tyler"))
      .findFirst()
      .ifPresent(System.out::println); // "Tyler Lawton"
  }
}

```

The declarative style wins for me.

- Java manages to shine in this case, because the chain of operations reads almost like English.
- The intent, which is to _print something if it's found_, is fully encapsulated - no intermediate variables, no scope change, no mutation.

The imperative style is also readable, but it's clunky.

- I have to instantiate an intermediate variable, `name`.
- I have to track the mutation of the `name` variable.
- The intent, which is to _print something if it's found_, is not encapsulated - it's spread across several scopes.
