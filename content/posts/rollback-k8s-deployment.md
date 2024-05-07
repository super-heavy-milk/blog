---
title: "Rollback a K8S deployment"
date: 2024-02-20T10:50:29-04:00
slug: 2024-02-20-rollback-a-k8s-deployment
summary: "This is a nice 'lil script for rolling back a kubernetes deployment."
draft: false
categories:
  - programming
tags:
  - fzf
  - bash
  - k8s
  - devops
---

This is a nice 'lil script for rolling back a k8s deployment.

_Note: this generates the command so you can copy it, it doesn't actually execute it_

```bash
#!/usr/bin/env bash

function undo_k8s_deployment() {
  local ctx name_space k8s_deployment k8s_revision command

  # choose a context
  ctx=$(
    kubectl config get-contexts -o name |
      awk '{print $1}' |
      fzf --prompt "Select a k8s context "
  )
  [[ -z "$ctx" ]] && echo "No k8s context selected, exiting." && exit 0

  # choose a namespace
  name_space=$(
    kubectl --context "$ctx" get namespace |
      awk 'NR!=1 {print $1}' |
      fzf --prompt "Select a k8s namespace "
  )
  [[ -z "$name_space" ]] && echo "No k8s namespace selected, exiting." && exit 0

  # pick a deployment
  k8s_deployment=$(
    kubectl --context "$ctx" -n "$name_space" get deployments |
      awk 'NR!=1 {print $1}' |
      fzf --prompt "Select a k8s deployment "
  )
  [[ -z "$k8s_deployment" ]] && echo "No k8s deployment selected, exiting." && exit 0

  # pick a revision to roll back to
  k8s_revision=$(
    kubectl --context "$ctx" -n "$name_space" rollout history deployment "$k8s_deployment" |
      # show the full deployments history menu to the user, so they have context
      fzf --tac --prompt "Select a revision number to roll back to (highest number is most recent deployment) " |
      # get the first column, which is the revision number
      awk '{print $1}'
  )
  [[ -z "$k8s_revision" ]] && echo "No k8s revision selected, exiting." && exit 0

  # generate the command to undo the deployment
  command="kubectl --context=$ctx -n=$name_space rollout undo deployment/$k8s_deployment --to-revision=$k8s_revision"
  echo "Copy and run this command to undo the deployment:"
  echo "$command"

  # exit cleanly
  exit 0
}

# call the function
undo_k8s_deployment
```
