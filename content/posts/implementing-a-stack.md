---
title: "Implementing a Stack"
date: 2024-05-01T12:30:33-04:00
slug: 2024-05-01-implementing-a-stack
summary: "Building a stack is a great way to learn about how you can create a useful data structure from low level building blocks."
type: posts
draft: false
categories:
  - programming
tags:
  - java
  - dsa
---

- [Introduction](#introduction)
- [What is a Stack?](#what-is-a-stack)
  - [FIFO](#fifo)
  - [LIFO](#lifo)
  - [Bags](#bags)
- [Implementations](#implementations)
  - [Array-Based FIFO Stack](#array-based-fifo-stack)

# Introduction

---

I've been trying to go through some DSA (Data Structures & Algorithms) stuff that I've forgotten in my time as a [digital plummer](https://www.karllhughes.com/posts/plumbing) at my last job.

It's humbling, to say the least. I suck at it. In my somewhat limited experience, most of _Software Engineering_ is stitching together disparate systems and turning out _product features_ as fast as humanly possible.

The upside is, when I learned DSA originally, I had no appreciation or perhaps _context_ for the use of this stuff. My mental model of what programming really does it much stronger, and I have to say, this stuff is much more interesting now.

# What is a Stack?

---

Stacks come in three basic flavors:

- FIFO (First-In, First-Out), also called a _Queue_
- LIFO (Last-In, First-Out), also called a _Pushdown Stack_
- Bag, a sort of read-only Stack

## FIFO

FIFO (Queue) Stacks adhere to this sort of API:

```java
public interface Fifo<Item> {
  void enqueue(Item item); // add an item
  Item dequeue(); // get the least recently added item and remove  it
  boolean isEmpty(); // see if the Queue is empty
  int size(); // number of items in the Queue
}

```

The thing to note about the Queue is that:

- Items are added to the top
- Items are retrieved from the bottom

A good real-word example of this waiting in line at the DMV.

- You get your place in line - _enqueue_
- You are now at the top of the Stack
- The DMV worker calls a number that is next - _dequeue_
- The person at the bottom of the stack is removed

## LIFO

LIFO (Pushdown) Stacks adhere to this sort of API:

```java
public interface Lifo<Item> {
  void push(Item item); // add an item
  Item pop(); // get the value of the most recently added item and remove it
  Item peek(); // get the value of the most recently added item
  boolean isEmpty(); // see if stack is empty
  int size(); // get stack length
}

```

The thing to note about the Pushdown Stack is that:

- Items are added to the top, like a FIFO stack
- Items are retrieved from the top, _unlike a FIFO stack_

I like to imagine a big 'ol stack of pancakes for this structure:

- You are at your mom's house for brunch
- She places 1, 2, 3, 4, 5, and finally 6 pancakes on your plate, in a stack.
- _"That's too many pancakes!"_ you exclaim!
- You have to trim down the stack to a reasonable size.
- To do so, you take them off _from the top_, one at a time, starting with pancake 6.

## Bags

I find Bags to be kinda funny, even cute. It's just a ...uh...bag to throw stuff into.

```java
public interface Bag<Item> {
  void add(Item item); // add an item
  void isEmpty(); // see if the bag is empty
  int size(); // number of items in the bag
}

```

# Implementations

---

There are basically two main ways to make a Stack:

- using an array
- using a linked list

## Array-Based LIFO Stack

The thing that makes this interesting/tricky is that the underlying array has to be grown/shrunk, and so you can't rely on simple `array.length` calls to get the number of items.

Instead, you have to track the item count separately.

```java
import java.util.Iterator;
import java.util.NoSuchElementException;

public class LifoStack<Item> implements Iterable<Item> {

  private static final int CAP = 8;
  private Item[] items;
  private int count;

  public LifoStack() {
    this.items = (Item[]) new Object[CAP];
    this.count = 0;
  }

  // add an item to the top of the stack
  public void push(Item item) {
    grow();
    items[count] = item;
    count++;
  }

  // get the value of the most recently added item and remove it
  public Item pop() {
    if (isEmpty()) {
      throw new NoSuchElementException("Stack Underflow");
    }
    Item item = items[count - 1];
    items[count - 1] = null;
    count--;
    shrink();
    return item;
  }

  // get the value of the most recently added item
  public Item peek() {
    if (isEmpty()) {
      throw new NoSuchElementException("Stack Underflow");
    }
    return items[count - 1];
  }

  // is the number of items 0? (not array.length == 0)
  public boolean isEmpty() {
    return count == 0;
  }

  // get the number of items (not the array length)
  public int size() {
    return count;
  }

  // for demonstration purposes
  public int arraySize() {
    return items.length;
  }

  // double the array size if at capacity
  private void grow() {
    boolean atCapacity = items.length == count;
    if (atCapacity) {
      int doubled = 2 * items.length;
      items = java.util.Arrays.copyOf(items, doubled); // re-assign
    }
  }

  // shrink the array by half if conditions are good
  private void shrink() {
    boolean tooMuchRoom = count > 0 && count == items.length / 4;
    if (tooMuchRoom) {
      int halved = items.length / 2;
      items = java.util.Arrays.copyOf(items, halved); // re-assign
    }
  }

  // Need a way to traverse the structure
  public Iterator<Item> iterator() {
    return new Reverse();
  }

  // Since this is is a "pancake stack",
  // iteration will start from the "top" and count down
  private class Reverse implements Iterator<Item> {

    // This provides a way to "count down" without
    // effecting the actual count
    private int innerCount;

    public Reverse() {
      innerCount = count - 1;
    }

    public boolean hasNext() {
      return innerCount >= 0;
    }

    public Item next() {
      if (!hasNext()) {
        throw new NoSuchElementException("Out of elements!");
      }
      Item i = items[innerCount];
      innerCount--;
      return i;
    }
  }

  // try it!
  public static void main(String[] args) {
    LifoStack<Integer> ls = new LifoStack();

    System.out.println("Fill up the stack");
    for (int i = 1; i <= 20; i++) {
      ls.push(i);
      System.out.println("Count: " + ls.size());
      System.out.println("Array Size: " + ls.arraySize());
    }

    System.out.println("\nShow Iteration");
    for (Integer i : ls) {
      System.out.println("Iterator: " + i);
    }

    System.out.println("\nEmpty the stack");
    for (int i = 1; i <= 20; i++) {
      ls.pop();
      System.out.println("Count: " + ls.size());
      System.out.println("Array Size: " + ls.arraySize());
    }
  }
}

```

One thing a keen reader may notice is that the code for `grow()` and `shrink()` is similar, and could be refactored to cut down on some structural duplication.

I prefer to do it this way as all the conditions for when a halving/doubling operation is necessary are completely local to the enclosing method.
