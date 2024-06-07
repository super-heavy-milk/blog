---
title: "Netrw"
date: 2024-05-20T17:29:06-04:00
slug: 2024-05-20-netrw
type: posts
summary: "bE a ViM mInAlmIsT"
draft: false
categories:
  - programming
tags:
  - neovim
---

{{< figure src="/party-loner-vim-resized.jpeg" title="Y'all like vim?" alt="a meme about vim" >}}

Programming is mostly thinking, followed by trying out a _probably wrong_ idea, and then more thinking. It's hard to demonstrate proficiency unless you're a competitive programmer and can spit out algorithms faster than ChatGPT can hallucinate them.

I'm not a competitive programmer by any means, so to address my lack of flash and panache, I've become increasingly savvy at using vim.

> _I use vim btw. Well, no, not for Java. Or debugging. Also, it's actually neovim._

What I lack in algorithmic finesse I make up for in a willingness to invest in skills employers will _never, ever_ care about. Take for example, [netrw](https://vimdoc.sourceforge.net/htmldoc/usr_22.html#22.1), vim's built-in file explorer.

To begin, choose an incantation to invoke:

```sh
# From the command line, in a directory
vi .

# While in vim
:Explore
```

Nice, now you're in netrw.

Here's a smattering of useful commands:

| Cmd    | Description                                                              |
| ------ | ------------------------------------------------------------------------ |
| i      | Cycle through netrw's display types                                      |
| %      | Create a file                                                            |
| d      | Create a directory                                                       |
| D      | Delete a file/directory                                                  |
| R      | Rename a file/directory                                                  |
| -      | Navigate up a directory level                                            |
| `<CR>` | Enter a file, or descend a directory level _(`<CR>` is vim for "Enter")_ |

Crazy! What a ride. On to customization.

Here are some settings I like:

```lua
-- in your init.lua

-- use tree mode by default
vim.g.netrw_liststyle = 3

-- 25% vertical split
vim.g.netrw_winsize = 25

-- The same keymap will both toggle open,
-- and toggle close a netrw vertical split
-- to the left of your working buffer
vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<CR>',
  { desc = '[E]xplore Files (Toggle)' }
)
```

## Enhance

When I'm using vim, my workflow usually looks something like this:

- `cd` into a project directory
- open vim in the project root via `vi .`
- navigate to the file I want to edit via either [telescope](https://github.com/nvim-telescope/telescope.nvim) or `:e path/to/file`

Here's where the workflow breaks down.

1. open vi in `blog/`
1. navigate to `content/posts/post_1.md`
1. toggle open netrw using `<leader>e`

When I toggle netrw open, it shows me the tree in the `cwd` (project root), like so:

```sh
../
blog/
| .git/
| .github/
| archetypes/
| assets/
| content/
| data/
| i18n/
| layouts/
| node_modules/
| public/
| resources/
| scratch/
| static/
```

I like that it keeps my root context.

What would be even better, is that when I toggle open netrw, my `root` context is preserved, and the filetree is expanded to the current file, like so:

```sh

blog/ <-- still starts from the project root
| .git/
| .github/
| archetypes/
| assets/
| content/
| | about/
| | posts/
| | | post_1.md <-- expanded to current file
| | | post_2.md
| | | post_3.md
| | _index.md
| data/
| i18n/
| layouts/
| node_modules/
| public/
| resources/
| scratch/
| static/

```

So, here is a _dubiously tested_ toggle function that opens netrw with the following settings:

- tree view
- directories expanded to the current file
- current file highlighted/focused
- buffer centered to highlight

Quite nice when you're deeply nested in some directory.

```lua
local u = require 'custom.utils'

local netrw_toggler = function()
  -- @type boolean - Tracks if a netrw split has been opened.
  local delete_and_rtn_early = false

  -- @type integer - Tracks the buffer number of the opened netrw split.
  local toggled_netrw_buf_num = -1

  -- @type integer - Holds an autocommand to fire upon netrw exit.
  local toggler_group =
    vim.api.nvim_create_augroup('toggler_group', { clear = true })

  return function()
    -------------------
    -- EARLY RETURN  --
    -------------------

    -- toggle should short circuit if only netrw is open
    if vim.bo.ft == 'netrw' and #vim.api.nvim_list_wins() == 1 then
      return
    end

    -- if already toggled open,
    -- use the stored state to delete the open buffer
    if delete_and_rtn_early and toggled_netrw_buf_num ~= -1 then
      vim.api.nvim_buf_delete(toggled_netrw_buf_num, {})
      -- because the buffer was deleted,
      -- the 'WinClosed' autocommand defined below will
      -- set `delete_and_rtn_early=false`
      return
    end

    ---------------------------
    -- BEFORE OPENING NETRW  --
    ---------------------------

    -- @type string - The buffer from which the cmd is launched.
    local cmd_buf = vim.api.nvim_buf_get_name(0)

    -- @type string
    local cmd_buf_parent_dir_path = vim.fs.dirname(cmd_buf) or '.'

    -- set the current file name as the last search,
    -- so it is highlighted/focused upon netrw open
    vim.cmd [[:let @/=expand("%:t")]]

    -- open netrw in left split
    vim.cmd('Lexplore ' .. cmd_buf_parent_dir_path)

    -------------------------
    -- AFTER OPENING NETRW --
    -------------------------

    -- set the variables captured by the closure
    delete_and_rtn_early = true
    toggled_netrw_buf_num = vim.api.nvim_get_current_buf()

    -- expand the tree for every parent directory til root is reached
    local root = u.get_project_root_dir() or vim.fn.getcwd()
    for dir in vim.fs.parents(cmd_buf) do
      if dir == root then
        break
      end
      vim.cmd "call netrw#Call('NetrwBrowseUpDir', 1)"
    end

    -- n<CR> will focus/highlight the last search, which was set above
    -- zz will center the buffer
    vim.cmd ':normal n<CR>zz'

    -- handle edge case: quitting netrw with command other than `<leader>e`
    vim.api.nvim_create_autocmd({ 'WinClosed' }, {
      group = toggler_group,
      buffer = toggled_netrw_buf_num, -- pin to the toggled buffer
      once = true, -- delete after firing, needed because of pin
      callback = function()
        delete_and_rtn_early = false
      end,
    })
  end
end

-- netrw settings
vim.g.netrw_winsize = 25 -- 25% vertical split
vim.g.netrw_liststyle = 3 -- use tree mode by default

-- this will store the state for the toggling command
local toggler = netrw_toggler()
vim.keymap.set('n', '<leader>e', toggler, { desc = '[E]xpore Files Toggle' })
```

You'll need something similar to this for the above to work (or just use the `cwd`).

```lua
-- @return string|nil
M.get_project_root_dir = function()
    return vim.fs.dirname(vim.fs.find({ '.git', '.editorconfig' }, {
      upward = true,
      stop = vim.loop.os_homedir(), -- non-inclusive, at home dir
      limit = 1, -- only care about first result, stop searching when found
    })[1])
end
```

Oh also, I lied.

> _I don't really know how to use netrw that well. The above is pretty much it._

Anyways, I need to go tweak my `.zshrc` so that that my prompt uses a more _subtle_ color palate. Should only take a couple of weeks.
