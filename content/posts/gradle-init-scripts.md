---
title: "Gradle Init Scripts"
date: 2024-05-06T14:40:39-04:00
slug: 2024-05-06-gradle-init-scripts
summary: "I should stop trying to do Unix-y stuff with Java."
type: posts
draft: false
categories:
  - programming
tags:
  - java
  - gradle
---

This is a nice hack taken from [Jamie Tanna](https://www.jvt.me/posts/2020/05/15/gradle-spotless/) on her blog.

You can create top-level Gradle tasks using [initialization scripts](https://docs.gradle.org/current/userguide/init_scripts.html) to apply common actions anytime Gradle is ran.

Gradle will look for init scripts (and execute them) in the following order:

1. `init.gradle` in the `$GRADLE_USER_HOME/` directory.
1. `*.gradle` in the `$GRADLE_USER_HOME/init.d/` directory.
1. `*.gradle` in the `$GRADLE_HOME/init.d/` directory, in the Gradle distribution.

You can also invoke init scripts using the `--init-script` or `-I` flag:

```sh
gradle --init-script init.gradle
```

See [Configuring the Gradle Build Environment](https://docs.gradle.org/current/userguide/build_environment.html) for more info.

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

This above snippet will do the following:

- If Spotless exists in a given project, it will apply the Spotless configuration:
  - _after_ the code has successfully compiled
  - _before_ any other configured tasks

Running tests or other static analysis tools could be applied in a similar fashion.
