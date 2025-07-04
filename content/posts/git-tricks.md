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
  - [checkout](#checkout)
  - [switch](#switch)
  - [restore](#restore)
- [Git Files](#git-files)
  - [.gitignore](#gitignore)

## Commands

Some common `git` commands I use frequently.

### checkout

The `checkout` command is _mostly_ used for switching branches (more on that below).

The two commands I use frequently are:

```sh
# switch to an existing branch
git checkout branch-name

# create a new branch and switch to it
git checkout -b new-branch

```

The above is probably the most common use of `checkout`.

### switch

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

Remember how you can discard local _unstaged_ changes using the `checkout` command? That's what `restore` does.

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

# This folder, every time
.idea/

# CMake
cmake-build-*/

# File-based project format
*.iws

# Another IntelliJ thing
out/

# mpeltonen/sbt-idea plugin
.idea_modules/

# JIRA plugin
atlassian-ide-plugin.xml

# Crashlytics plugin (for Android Studio and IntelliJ)
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties

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

### .gitconfig

This one is pretty self-explanatory.

Below is mine, currently. A lot of the settings are pulled from these two rather excellent articles:

- [how git core devs configure git](https://web.archive.org/web/20250623214103/https://blog.gitbutler.com/how-git-core-devs-configure-git/)
- [10 git aliases for faster and productive git workflow](https://web.archive.org/web/20250325045559/https://snyk.io/blog/10-git-aliases-for-faster-and-productive-git-workflow/)

Note that mine is... messier, especially the aliases.

```toml
[user]
	name = Tyler Lawton
	email = <redacted>

[core]
	autocrlf = input
	pager = delta
	#excludesFile = ~/.config/git/ignore  # global ignore file

[interactive]
	diffFilter = delta --color-only

[delta]
	navigate = true
	#side-by-side = true

[merge]
	conflictstyle = diff3
	tool = nvimdiff

[diff]
	colorMoved = default
	renames = true
	mnemonicPrefix = true
	algorithm = histogram

[commit]
	verbose = true

[push]
	autoSetupRemote = true

[pull]
	ff = only

[tag]
	sort = version:refname

[branch]
	sort = -committerdate

[rerere]
	enbabled = true
	autoupdate = true

[rebase]
	autoSquash = true
	autoStash = true
	updateRefs = true # look into this more

[alias]
	s = status --untracked-files=no
	co = checkout
	cob = checkout -b
	del = branch -D
	save = !git add -u && git commit
	c = commit
	p = push
	aa = add -u
	undo = reset HEAD~1 --mixed
	res = !git reset --hard
	done = !git push origin HEAD
	#br = branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate
	br = !git branch --format='%(HEAD)»%(color:yellow)%(refname:short)%(color:reset)»%(contents:subject)%(color:green)»(%(committerdate:relative))»%(authorname)' --sort=-committerdate | column -t -s '»'
	#lg = !git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30
	lgg = !git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30
	lg = !git log --pretty=format:'%C(magenta)%h%Creset»%C(red)»%d%Creset %s %C(dim green)»%cr»%an' --abbrev-commit -30 | column -t -s '»'
	df = difftool --no-prompt
	file-hist = log -p -- %f
	latest-version = !git -c 'versionsort.suffix=-'' ls-remote --exit-code --refs --sort='version:refname' --tags `git config --get remote.origin.url` '*.*.*' 2> /dev/null | tail --lines=1 | cut -d '/' -f 3
	load-unstaged = !${EDITOR} `git diff --name-only`
	commits-from-master-missing-in-develop = !git fetch --quiet && git log origin/develop..origin/master --oneline --no-merges
	commits-from-develop-missing-in-HEAD = !git fetch --quiet && git log HEAD..origin/develop --oneline --no-merges
	graph = log --all --graph --pretty=format:'%C(magenta)%h%Creset %C(red) %d%Creset %s %C(dim green) %cr %an'
```
