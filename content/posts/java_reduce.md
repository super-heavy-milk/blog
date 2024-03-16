+++
title = 'Reducing in Java'
date = 2024-03-16T10:51:08-04:00
draft = true
+++


This is a thing that I have to look up and relearn every time I want to do it in Java, so here we go.

> What is a reduce operation?
>
> _Reduce is a way to produce a single result when iterating over a sequence._

This is technique that comes from functional programming. The main benefit, is that you can _assign_ a variable declaratively from the result of a reduce. 

```javascript
// array to iterate over
const arr = [1, 2, 3, 4];

// imperitive 
let imperitiveSum = 0;
for (const i of arr) {
  imperitiveSum = imperitiveSum + i;
}
console.log(imperitiveSum); // 10

// functional 
const functionalSum = arr.reduce((sum, i) => sum + i, 0);
console.log(functionalSum); // 10
```

In the example above, the thing to note is the scope of `imperitiveSum` vs `functionalSum` - notice how `functionalSum` is derived once by the reduce funciton, while `imperitiveSum` requires the reader to track the mutation of the variable. 

That's it - that's the benefit. 

> Javascript isn't really good language to showcase this as it doesn't have immutable variables, but I wanted to pick something concise that most people would be familiar with.

Ok, cool. You said this was a post about Java though?

_Right, right._

So, enter Java.

Java is...a good language to find employment with. I'll say that. And it has some really nice language features (too many, actually, but I digress).

One perennial favorite of mine is the [Streams](https://docs.oracle.com/en/java/javase/21/docs/api//java.base/java/util/stream/Stream.html) api, which allows for functional-style iteration techniques.



