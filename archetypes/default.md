---
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
date: "{{ .Date }}"
slug: '{{ .Date | time.Format "2006-01-02" }}-{{ replace .File.ContentBaseName "_" "-" }}'
summary: "todo"
draft: true
categories:
  - programming
tags:
  - todo
---
