---
title: "Git In My Bellauh"
date: 2024-04-23T16:46:44-04:00
slug: 2024-04-23-git-tricks
type: posts
summary: "Git lore and trivia I've picked up."
draft: false
categories:
  - programming
tags:
  - git
---

_Note: This is woefully incomplete. I'll be adding more over time._

![Fat Bastard yelling "Get in my belly"](/fat_bastard.jpeg)

## Table of Contents

- [Commands](#commands)
  - [checkout/switch](#checkoutswitch)
  - [restore](#restore)
- [Git Files](#git-files)
  - [.gitignore](#gitignore)

## Commands

Some common `git` commands I use frequently.

### checkout/switch

The practical difference between `git switch` and `git checkout` comes down to:

> _files vs branches_

For example:

1. I make some changes to `turbo_ml.py`
1. The changes are now _unstaged_.
1. I don't like them, and want to reset the file and start over.

I can run the following to reset the file to the last commit:

```sh
git checkout -- turbo_ml.py
```

Bonus for vimmers:

> You can run `:!git checkout -- %` right from the editor.

The "gotcha" is that:

> **Given** there is a git _branch_ called `turbo_ml.py`.
>
> **When** I omit the `--` from the `checkout` command.
>
> **Then** git will checkout the `turbo_ml.py` _branch_ instead of resetting the _file_.

Granted, it's pretty unlikely that you will have a git branched called "turbo_ml.py" but stranger things have happened.

Consequently, this is why the `git switch` (and `git restore`, see below) command was introduced in [Git's 2019 v2.23.0 release](https://public-inbox.org/git/xmqqy2zszuz7.fsf@gitster-ct.c.googlers.com/).

- The `switch` command **can** checkout a branch
- The `switch` command **can't** revert/reset a file.
- It's less flexible, but that's the point - less room for error.

### restore

I wanted to include `git restore` after explaining `checkout` vs `switch`.

Remember how you can discard can discard local _unstaged_ changes using the `checkout` command? That's what `restore` does.

```sh
# using checkout
git checkout -- turbo_ml.py

# using restore
git restore turbo_ml.py
```

> Because the `restore` command has no capability to _checkout_ a branch, there is no need to include the `--` safeguard that the `checkout` command requires.

There is another reason to use the `restore` command:

- If you have _staged_ a file, you can unstage it without discarding your local changes.

```sh
# no longer staged for commit + local changes are still there
git restore --staged turbo_ml.py
```

Bonus for vimmers:

> You can run `:!git restore --staged %` right from the editor.

## Git Files

There are a couple of files that Git uses for settings and other stuff.

### .gitignore

The [.gitignore](https://git-scm.com/docs/gitignore) file is widely used and you've probably come across it if you have done any programming.

> _I like to use this [repo](https://github.com/github/gitignore) for getting templates for specific repositories or projects._

What's not commonly discussed that I find to be useful is that you can have a **global** `.gitignore` in the `~/.config/git/ignore` file _(note the lack of extension)_.

> _The global ignore file is great for common editor, OS, library, etc settings._

Example Global `ignore` file:

```sh
#######
# vim #
#######

# swap
[._]*.s[a-v][a-z]
!*.svg  # comment out if you don't need vector files
[._]*.sw[a-p]
[._]s[a-rt-v][a-z]
[._]ss[a-gi-z]
[._]sw[a-p]

# session
Session.vim
Sessionx.vim

# temporary
.netrwhist
*~

# auto-generated tag files
tags

# persistent undo
[._]*.un~

###########
# vs code #
###########
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
!.vscode/*.code-snippets

## Local History for Visual Studio Code
.history/

## Built Visual Studio Code Extensions
*.vsix

#############
# JetBrains #
#############

# User-specific stuff
.idea/**/workspace.xml
.idea/**/tasks.xml
.idea/**/usage.statistics.xml
.idea/**/dictionaries
.idea/**/shelf

# AWS User-specific
.idea/**/aws.xml

# Generated files
.idea/**/contentModel.xml

# Sensitive or high-churn files
.idea/**/dataSources/
.idea/**/dataSources.ids
.idea/**/dataSources.local.xml
.idea/**/sqlDataSources.xml
.idea/**/dynamic.xml
.idea/**/uiDesigner.xml
.idea/**/dbnavigator.xml

# Gradle
.idea/**/gradle.xml
.idea/**/libraries

# CMake
cmake-build-*/

# Mongo Explorer plugin
.idea/**/mongoSettings.xml

# File-based project format
*.iws

# IntelliJ
out/

# mpeltonen/sbt-idea plugin
.idea_modules/

# JIRA plugin
atlassian-ide-plugin.xml

# Cursive Clojure plugin
.idea/replstate.xml

# SonarLint plugin
.idea/sonarlint/

# Crashlytics plugin (for Android Studio and IntelliJ)
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties

# Editor-based Rest Client
.idea/httpRequests

# Android studio 3.1+ serialized cache file
.idea/caches/build_file_checksums.ser

#########
# MacOS #
#########

# General
.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon

# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk

##########
# NodeJs #
##########
node_modules
package-lock.json
bower_components

```
