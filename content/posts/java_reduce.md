+++
title = 'Reducing in Java'
date = 2024-03-16T10:51:08-04:00
draft = true
+++


This is a thing that I have to look up and relearn every time I want to do it in Java, so here we go.

> What is a reduce operation?
>
> _Reduce is a way to produce a single result when iterating over a sequence._

This is technique that comes from functional programming. There are a lot of opinions out there concerning the relative merit of functional vs OOP vs imperative, but this is little article is not one of them. The main benefit (at least for me) is that you can _assign_ a variable _declaratively_ from the result of a reduce. 

Python sort-of gives you this behavior natively, in the form of [list comprehensions](https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions):

```python
nums = [1, 2, 3, 4]

# imperative
four = None
for x in nums:
    if x == 4:
        four = 4

# declarative
three = [x for x in nums if x == 3] 
```
The above is a contrived example, but you can see why it's easier to see the _intent_ of the code with the declarative style.

> OK, cool. You said this was a post about Java though?
>
> _Right, right..._

So, enter Java.

Java is...a good language to find employment with. I'll say that. And it has some really nice language features (too many, actually, but I digress).

One perennial favorite of mine is the [Streams](https://docs.oracle.com/en/java/javase/21/docs/api//java.base/java/util/stream/Stream.html) API, which allows for functional-style iteration techniques.

Let's do another contrived example.

```java
val nums = List.of(1, 2, 3, 4);

// imperative 
val four = null;
for (Integer i : nums) {
  if (i == 4) {
    four = 4;
  }
}

// declarative
val three = nums.stream()
              .filter(x -> x == 4)
              .collect()
```

