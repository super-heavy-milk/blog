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
- [Git Files](#git-files)
  - [.gitignore](#gitignore)

## Commands

Some common `git` commands I use frequently.

### checkout/switch

The practical difference between `git switch` and `git checkout` comes down to:

- _files vs branches_.

For example:

1. I make some changes to `state_of_the_art_ai.py`
1. The changes are now unstaged (or staged).
1. I don't like them, and want to reset the file and start over.

I can run the following to reset the file to the last commit:

```sh
git checkout -- state_of_the_art_ai.py
```

Bonus:

> If you're in vim, you can run `:!git checkout -- %` right from the editor.

The "gotcha" is that:

> **given** I omit the `"--"` from the command
>
> **and** there is a git branch called `state_of_the_art_ai.py`
>
> **then** git will switch to that branch instead of resetting the file.

Thus the `git switch` command - it will always checkout a branch, never a file.

## Git Files

There are a couple of files that Git uses for settings and other stuff.

### .gitignore

The [.gitignore](https://git-scm.com/docs/gitignore) file is widely used and you've probably come across it if you have done any programming.

I like to use this [repo](https://github.com/github/gitignore) for getting ideas or templates for specific repositories or projects.

What's not commonly known that's useful is that you can have a _global_ `.gitignore` in the `~/.config/git/ignore` file _(note the lack of extension)_.

> Great for common editor, OS, library, etc settings.

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
