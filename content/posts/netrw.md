---
title: "Netrw"
date: 2024-05-17T17:29:06-04:00
slug: 2024-05-17-netrw
draft: false
type: posts
summary: "bE a ViM mInAlmIsT"
categories:
  - programming
tags:
  - neovim
---

_Y'all like vim?_

{{< figure src="/party-loner-vim2-1.jpeg"  title="Is omitting 'that' a grammatical error?" alt="a meme about vim" >}}

Programming is mostly thinking, followed by trying out a _probably wrong_ idea, and then more thinking. It's hard to demonstrate proficiency unless you're a competitive programmer and can spit out algorithms faster than ChatGPT can hallucinate them.

I'm not a competitive programmer by any means, so to address this deficiency, I've become increasingly savvy at using vim. As a mature, confident man in my mid-30's, it's important that I have something to flaunt in front of potential rival programmers.

> _I use vim btw. Well, no, not for Java. Or debugging. Also, it's actually neovim._

What I lack in algorithmic finesse I make up for in a willingness to invest in skills employers will _never, ever_ care about. Take for example, [netrw](https://vimdoc.sourceforge.net/htmldoc/usr_22.html#22.1), vim's built-in file explorer.

To begin, invoke the following incantation:

```vim
:E
```

Nice, now you're in netrw.

Here's a smattering of useful commands:

| Cmd    | Description                                  |
| ------ | -------------------------------------------- |
| i      | Change netrw display                         |
| %      | Create a file                                |
| d      | Create a directory                           |
| D      | Delete a file/directory                      |
| R      | Rename a file/directory                      |
| -      | Navigate up a directory level                |
| `<CR>` | Enter a buffer _(`<CR>` is vim for "Enter")_ |

Crazy! What a ride. On to customization.

Here are some settings I like:

```lua
-- in your init.lua

-- use tree mode by default
vim.g.netrw_liststyle = 3

-- 20% vertical split
vim.g.netrw_winsize = 20

-- The same keymap will both toggle open,
-- and toggle close a netrw vertical split
vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<CR>',
  { desc = '[E]xplore Files (Toggle)' }
)
```

Oh also, I lied.

> _I don't really know how to use netrw that well. The above is pretty much it._

Anyways, I need to go tweak my `.zshrc` so that that my prompt uses a more _subtle_ color palate. Should only take a couple of weeks.