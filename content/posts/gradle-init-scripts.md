---
title: "Gradle Init Scripts"
date: 2024-05-06T14:40:39-04:00
slug: 2024-05-06-gradle-init-scripts
summary: "I should stop trying to do Unix-y stuff with Java but whatever."
type: posts
draft: true
categories:
  - programming
tags:
  - gradle
---

This is a nice hack taken from [Jamie Tanna](https://www.jvt.me/posts/2020/05/15/gradle-spotless/) on her blog.

You can create a top-level Gradle files for stuff using Gradle's [initialization scripts](https://docs.gradle.org/current/userguide/init_scripts.html) to apply common actions anytime Gradle is ran.

Gradle will look for init scripts (and execute) in the following order:

- `init.gradle` in the `$GRADLE_USER_HOME/` directory.
- `*.gradle` in the `$GRADLE_USER_HOME/init.d/` directory.
- `*.gradle` in the `$GRADLE_HOME/init.d/` directory, in the Gradle distribution.

You can also invoke init scripts using the `--init-script` or `-I` flag:

```sh
gradle --init-script init.gradle
```

Here's an example for a `~/.gradle/init.d/spotless.gradle` file:

```groovy

allprojects {
  afterEvaluate {
    def spotless = tasks.findByName('spotlessApply')
    if (spotless) {
      tasks.withType(JavaCompile) {
        finalizedBy(spotless)
      }
    }
  }
}
```

Note the use of `allprojects`.

- If spotless exists in a given project, it will apply the Spotless configuration:
  - after the code has successfully compiled
  - before any other configured tasks
