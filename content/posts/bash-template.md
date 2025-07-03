---
title: "Bash Template"
date: "2025-07-03T12:18:08-04:00"
slug: "2025-07-03-bash-template"
summary: "My bash template"
draft: false
categories:
  - programming
tags:
  - bash
---

Quick post today.

I wrote a lot of bash scripts over the past year.

This is the template I've landed on for starting a new bash script.

It's not perfect, but it gets the job done and _crucially_, it works with the default bash version on MacOS and git-bash on Windows.

```bash
#!/usr/bin/env bash

[[ -n ${TRACE:-} ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail

# https://no-color.org/
if [[ -n ${NO_COLOR:-} ]]; then
  k='' r='' g='' y='' b='' p='' c='' z='';
else
  k='\033[0;90m' r='\033[31m' g='\033[32m' y='\033[33m' b='\033[34m' p='\033[35m' c='\033[36m' z='\033[0m';
fi

usage() {
  local name; name="${c}./$(basename "$0")${z}"
  cat << EOF
${y}Usage:${z} $name [-h] ARGS

  TODO ADD HELP TEXT

${g}OPTIONS${z}
  -h, --help    Show help

${g}EXAMPLES${z}
  ${k}# suppress color output${z}
  NO_COLOR=1 ${name} ARGS

  ${k}# debug${z}
  TRACE=1 ${name} ARGS
EOF
} && [[ "${1-}" =~ ^--?h(elp)?$ ]] && echo -e "$(usage)" && exit 0

# utils
onpath()   { command -v "${1:?Provide an executable name as first param}" > /dev/null 2>&1 ; }
getpath()  { onpath "${1}" && which "${1}" ; }
err()      { echo -e "${r}ERROR${z} $*" 1>&2 ; }
warn()     { echo -e "${y}WARN${z} $*" 1>&2 ; }
info()     { echo -e "${b}INFO${z} $*" 1>&2 ; }
die()      { err "$*" && exit 1 ; }
getos() {
  case "$OSTYPE" in
    msys*)    echo 'win' ;;
    cygwin*)  echo 'win' ;;
    darwin*)  echo 'mac' ;;
    solaris*) echo "nix" ;;
    linux*)   echo "nix" ;;
    bsd*)     echo "nix" ;;
    *)        die "unsupported $OSTYPE" ;;
  esac
}
```
