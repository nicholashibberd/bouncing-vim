What is it?
-----------

bouncing.vim is a mini vim distro, integrated with tmux.

It's a curated collection of plugins and settings, inspired by a few key
principles:

* provide a practical, "human" Vim setup
* provide as many additional features and shortcuts as possible...
* ...but try to not remove or override native Vim features and popular setups
* allow people with different experiences to pair program proficiently and
  pleasantly

It supports temporary installation of the vim plugins by taking advantage
of pathogen - useful for pairing sessions.

Credits are currently given in the form of links to the original source.
Thanks to the great Vim community and to the many authors of the features.

Third party plugins
-------------------

Install all the plugins (including the nice-to-have's) with:
`./vim-scripts/install-plugins.sh`

### Essentials

* [Ack-vim] (https://github.com/mileszs/ack.vim) - Run [ack] (http://beyondgrep.com/)
  from vim, and shows the results in a split window.
* [Ctrl-P] (https://github.com/kien/ctrlp.vim) - Full path fuzzy file, buffer,
  mru, tag, ... finder for Vim, written in pure Vimscript.
* [MiniBufExplorer] (https://github.com/fholgado/minibufexpl.vim) -
  Elegant buffer explorer, takes very little screen space.
* [NERDTree] (https://github.com/scrooloose/nerdtree) - Explore the filesystem
  in a hierarchical tree structure and open files and directories.
* [Supertab] (https://github.com/ervandew/supertab) - Perform all your vim insert
  mode completions with Tab.
* [Tabular] (https://github.com/godlygeek/tabular) - Vim script for text
  filtering and alignment.
* [Buffergator] (https://github.com/jeetsukumaran/vim-buffergator) - Vim plugin
  to list, select and switch between buffers.
* [commentary.vim] (https://github.com/tpope/vim-commentary) - Comment stuff out.
* [Multiple cursors] (https://github.com/terryma/vim-multiple-cursors) -
  Sublime Text style multiple selections for Vim.
* [Sensible] (https://github.com/tpope/vim-sensible) - A universal set of
  defaults that (hopefully) everyone can agree on.
* [Surround] (https://github.com/tpope/vim-surround) - Edit parentheses,
  brackets, quotes, XML tags, and more in pairs.
* [Vimux] (https://github.com/benmills/vimux) - Easily interact with tmux from vim.

Colorschemes

* [Agnostic] (https://github.com/ygt-mikekchar/agnostic) - A vim colour scheme
  that allows to choose your own colours.
* [Molokai] (https://github.com/tomasr/molokai) - A Vim port of the monokai
  theme for TextMate.
* [Solarized] (https://github.com/altercation/vim-colors-solarized) - Precision
  colors for machines and people.

### Nice-to-have's

Install with: `./vim-scripts/tmp-plugins-install.sh`.

Remove with: `./vim-scripts/tmp-plugins-install.sh`.

* [Mustache] (https://github.com/mustache/vim-mustache-handlebars) - A vim plugin for
  working with mustache and handlebars templates.
* [Python Syntax] (https://github.com/hdima/python-syntax) - Python syntax
  highlighting script for Vim.
* [Ultisnips] (https://github.com/SirVer/ultisnips) - An implementation
  of TextMates Snippets for the Vim Text Editor. Requires Vim compiled with
  Python support.
* [Coffeescript] (https://github.com/kchmck/vim-coffee-script) - Adds
  CoffeeScript support to vim. It covers syntax, indenting, compiling, and more.
* [fugitive.vim] (https://github.com/tpope/vim-fugitive) - A Git wrapper so
  awesome, it should be illegal.
* [HiLinkTrace] (https://github.com/gerw/vim-HiLinkTrace) - Get the color of the
  text object under the cursor.
* [Markdown] (https://github.com/tpope/vim-markdown) - Vim Markdown runtime files.
* [rails.vim] (https://github.com/tpope/vim-rails) - Ruby on Rails power tools.
* [Vim Ruby] (https://github.com/vim-ruby/vim-ruby) - Vim configuration files
  for editing and compiling Ruby within Vim.
* [vim-ruby-xmpfilter] (https://github.com/t9md/vim-ruby-xmpfilter) - Helper
  for ruby's xmpfilter or seeing_is_believing. Evaluates Ruby code inline and
  print the result as a comment at the end of the line.

Colorschemes:

* [Noctu] (https://github.com/noahfrederick/vim-noctu) - A Vim color scheme for
  16-color terminals.
* [Base16] (https://github.com/chriskempson/base16-vim) - Color schemes for hackers.

Installing
----------

Installation of Vim and tmux supports Ubuntu (tested on 12.04).

The plugins use pathogen.

### Install Vim 7.4 from source (only Ubuntu)

To download and compile, run:

```sh
./vim-scripts/install-vim-from-source-ubuntu.sh
```

Vim will be compiled with "features=huge", Python and Perl support.

If system Ruby is available it will also be compiled with Ruby support.
Otherwise the script will give the option to install Ruby 1.9.3 from the
Ubuntu repositories and compile with it, or to compile without Ruby support.

### Install the vim plugins (with pathogen)

The list of essential and nice-to-have plugins is in `./vim-script/plugins.sh`

* If a full install is required: run `vim-scripts/install-plugins.sh`.

* If a temporary install is preferred:
  - run `vim-scripts/tmp-plugins-install.sh` at the beginning of the pairing session
  - run `vim-scripts/tmp-plugins-remove.sh` when finished

### Install tmux 1.8 from source (only Ubuntu)

To download and compile, run:

```sh
./tmux-scripts/1-tmux-install-from-source.sh
```

It will also offer to link to the provided tmux.conf file.
Alternatively, from the file `./rc-files/tmux.conf`, copy to your tmux.conf
the two sections:

* "Terminal compatibility" (required in particular to pass some key
  combinations through tmux to vim)

* "Navigation between tmux and vim"

### Updating existing vim plugins

Updating all the vim plugins can be done with this oneliner:

```sh
cd ~/.vim/bundle && { \
ls -lA | \
  grep ^d | \
  sed -E 's/.+[[:digit:]]{2}:[[:digit:]]{2}\s*(.+)/\1/g' | \
  while read repo; do \
    echo "---- $repo ----"; \
    cd $repo; \
    git pull origin master; \
    cd ..; \
    echo; \
  done; \
cd -; \
}
```

Features
--------

> This is a partial list, work in progress.

### Third party plugins setup

* **CtrlP**
  - show hidden files
  - ignore some common dirs and file types

* **Ack**
  - launch `:Ack!` with `<leader>a`
  - use [Ag The Silver Searcher] (https://github.com/ggreer/the_silver_searcher)
    if available, to go even faster

* **NERDTree**
  - toggle with `<leader>n`
  - jump to the current buffer with `<leader>f` (as in "find...")
  - ignored compiled files
  - use minimal UI
  - prevent NERDTree from opening a buffer in a new split by mistake

* **vimux**
  - `<leader>rb`: run the current file with rspec
  - `<leader>rp`: prompt for a command to run
  - `<leader>rr`: run last command executed by VimuxRunCommand
  - `<leader>ri`: inspect runner pane
  - `<leader>rx`: close all other tmux panes in current window
  - `<leader>rq`: close vim tmux runner opened by VimuxRunCommand
  - `<leader>rs`: interrupt any command running in the runner pane

* **Vim Ruby**
  - turn on ruby evaluation for c-x c-o expansion
  - autocomplete class names in the global scope
  - autocomplete Rails methods
  - enable syntax highlight for Ruby operators

* **Ruby xmpfilter**
  - in terminal Vim press `F4` to mark the line, `F5` to evaluate
  - in Gvim press `Meta-m` to mark the line, `Meta-r` to evaluate

* **MiniBufExplorer**
  - position at the top
  - do not open by default
  - focus the buffer list with `<leader>t`
  - toggle the buffer list with `<leader>m`

* **Buffergator**
  - open on the right hand side
  - toggle with `<leader>+b`

### Language specific settings

* **Java**
  - soft tab with 4 spaces

* **Python**
  - soft tab with 4 spaces
  - use `indent` as `foldmethod`

* **golang**
  - hard tabs with 4 spaces
  - see also `./rc-files/vimrc` for the standard golang setup

* **Vim Ruby**
  - turn on ruby evaluation for c-x c-o expansion
  - autocomplete class names in the global scope
  - autocomplete Rails methods
  - enable syntax highlight for Ruby operators

* **Ruby xmpfilter**
  - in terminal Vim press `F4` to mark the line, `F5` to evaluate
  - in Gvim press `Meta-m` to mark the line, `Meta-r` to evaluate

### Miscellaneous options

* Reduce the timeout required to recognize a command from 1000 ms (the default)
  to 350 ms.

* Remove the comment symbols when joining lines with `J`.

### Miscellaneous mappings

* Map `<F1>` to `<Esc>` to avoid bringing up the help by mistake.

* Map `jj` to `<Esc>`, a popular shortcut that allows some users to stay on
  the home row.

* Toggle `paste` with `<F3>`, that disables all automatic indentation when
  pasting from the system clipboard.

### Navigation

* Arrows are fully enabled to accommodate users that have different styles of
  usage.

* Moving between lines works by visible lines instead of actual lines (useful
  when wrap is enabled).

* Home key
  - pressing the home key will bring to the first non-blank character (like `^`)
  - pressing again will bring to the first column (like `0`)
  - after that it will toggle between the two positions

A keycode fix is provided for this to work inside Tmux.

### Mouse support

Mouse features are fully enabled.

### Anti-typo command aliases

Some commands like `:w`, `:q` and similar have been aliased with the upper
case version to account for common misspellings.

### Last position in file

Reopening a file the cursor will jump to the position where it was the last
time the buffer was opened.

### Bubbling lines

With `CTRL+ArrowUp` and `CTRL+ArrowDown` (single lines in normal mode,
multiple lines in visual mode).

Keycode fixes are provided for this to work in Tmux as well.

Note that this doen't interfere with the copy and cut operations.

### Buffer enhancements

* Reuse a buffer if a file is already open

* Switch between buffers with the same shortcuts used for tabs in Chrome:
  `CTRL+PageUp/PageDown`;
  on those machines where that doesn't work, `<leader>+[` and `<leader>+]` can
  be used.

* Quick close the current buffer without closing its window with `CTRL+q`, or
  `ALT+q`, or `<leader>+q`.

* Close all buffers
  - all the non-special ones with the sequence `bda`
  - only the hidden ones with the sequence `bdh` in normal mode

* Copy the path of the current buffer to the system clipboard
  - relative path with the sequence `cp` in normal mode
  - full path with the sequence `cpp` in normal mode

* MiniBufExplorer customisation
  - position at the top
  - do not open by default
  - focus the buffer list with `<leader>t`
  - toggle the buffer list with `<leader>m`

* Buffergator plugin customisation
  - open on the right hand side
  - toggle with `<leader>+b`

### Clipboard

* Yank to the end of the line with `Y`, to make it consistent with `C` and `D`.
  This was removed from sensible.vim.

* Copy the visual selection to the system clipboard with `CTRL+c`.
  For Mac users requires additional configuration:
  <https://coderwall.com/p/j9wnfw>

* Configuration is provided to support system clipboard in Tmux as well,
  see `./plugin/clipboard.vim`

* In visual mode, use `<leader>p` to paste from the default register without
  replacing the content of the register.
  This allows to paste multiple times the same text.

### Real delete

Vim conflates the two functionalities of deleting and cutting.

The `ALT+d` (or `<leader>d`) shortcut provided to do real deletion
(cut to the blackhole register in Vim parlance):

* current line in normal mode
* selection in visual mode
