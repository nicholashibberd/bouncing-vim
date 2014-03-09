What is it?
-----------

bouncing.vim is a mini Vim distro, integrated with tmux.

It's a curated collection of plugins and settings, inspired by a few key
principles:

* provide a practical, "human" Vim setup
* provide as many additional features and shortcuts as possible...
* ...but try to not remove or override native Vim features and popular setups
* allow people with different experiences to pair program proficiently and
  pleasantly

It supports temporary installation of the Vim plugins by taking advantage
of pathogen - useful for pairing sessions.

If you are already using [pathogen.vim] (https://github.com/tpope/vim-pathogen),
this distro can just be considered an extension of your existing setup.
Chances are that you already have most of the third party plugins of this
distro, as they are amongst the most popular.

Credits are currently given in the form of links to the original source.
Thanks to the great Vim community and to the many authors of the features.

Content
-------

* [Third party plugins](#plugins-list)
  - [Essentials](#essential-plugins)
  - [Nice-to-have's](#nice-to-have-plugins)
* [Installing](#installing)
  - [Install Vim 7.4 from source (only Ubuntu)](#install-vim-source-ubuntu)
  - [Install the Vim plugins (with pathogen)](#install-vim-plugins)
  - [Install tmux 1.9 from source (only Ubuntu)](#install-tmux-source-ubuntu)
  - [Tmux configuration notes](#tmux-conf-notes)
  - [Updating existing Vim plugins](#update-existing-plugins)
* [Features](#features)
  - [Third party plugins setup](#third-party-plugins-setup)
  - [Language specific settings](#language-specific-settings)
  - [Miscellaneous options](#miscellaneous-options)
  - [Miscellaneous mappings](#miscellaneous-mappings)
  - [Navigation](#navigation)
  - [Mouse support](#mouse-support)
  - [Anti-typo command aliases](#anti-typo-aliases)
  - [Last position in file](#last-position-in-file)
  - [Bubbling lines](#bubbling-lines)
  - [Buffer enhancements](#buffer-enhancements)
  - [Clipboard](#clipboard)
  - [Real delete](#real-delete)
  - [Current directory](#current-directory)
  - [Read and write options](#read-write-options)
  - [Search features](#search-features)
  - [Run shell command without prompting](#shell-commands-without-prompt)

## <a name="plugins-list"></a>Third party plugins

Install all the plugins (including the nice-to-have's) with:
`./vim-scripts/install-plugins.sh`

To install only the essentials, and only temporarily:
* install with: `./vim-scripts/tmp-plugins-install.sh`.
* remove with: `./vim-scripts/tmp-plugins-remove.sh`.

### <a name="essential-plugins"></a>Essentials

* [Ack-vim] (https://github.com/mileszs/ack.vim) - Run [ack] (http://beyondgrep.com/)
  from Vim, and shows the results in a split window.
* [Ctrl-P] (https://github.com/kien/ctrlp.vim) - Full path fuzzy file, buffer,
  mru, tag, ... finder for Vim, written in pure Vimscript.
* [MiniBufExplorer] (https://github.com/fholgado/minibufexpl.vim) -
  Elegant buffer explorer, takes very little screen space.
* [NERDTree] (https://github.com/scrooloose/nerdtree) - Explore the filesystem
  in a hierarchical tree structure and open files and directories.
* [Supertab] (https://github.com/ervandew/supertab) - Perform all your Vim insert
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
* [Vimux] (https://github.com/benmills/vimux) - Easily interact with tmux from Vim.

Colorschemes

* [Agnostic] (https://github.com/ygt-mikekchar/agnostic) - A Vim colour scheme
  that allows to choose your own colours.
* [Molokai] (https://github.com/tomasr/molokai) - A Vim port of the monokai
  theme for TextMate.
* [Solarized] (https://github.com/altercation/vim-colors-solarized) - Precision
  colors for machines and people.

### <a name="nice-to-have-plugins"></a>Nice-to-have's

These are only installed when running the full install: `./vim-scripts/install-plugins.sh`

* [Mustache] (https://github.com/mustache/vim-mustache-handlebars) - A Vim plugin for
  working with mustache and handlebars templates.
* [Python Syntax] (https://github.com/hdima/python-syntax) - Python syntax
  highlighting script for Vim.
* [Ultisnips] (https://github.com/SirVer/ultisnips) - An implementation
  of TextMates Snippets for the Vim Text Editor. Requires Vim compiled with
  Python support.
* [Coffeescript] (https://github.com/kchmck/vim-coffee-script) - Adds
  CoffeeScript support to Vim. It covers syntax, indenting, compiling, and more.
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

## <a name="installing"></a>Installing

Installation of Vim and tmux supports Ubuntu (tested on 12.04).

The plugins use pathogen.

### <a name="install-deb-packages"></a>Install Vim and Tmux from .deb packages

Packages for Ubuntu 12.04 are provided in `./packages/`.

To install them, use "gdebi", because "dpkg -i" is not able to install the
dependencie declared in the package.
To install gdebi: `sudo apt-get install gdebi-core`.

Tha packages might work on different Ubuntu versions if the name of the
dependencies has not changed.

To see the dependencies before installing, use `dpkg -I`, for example:

```sh
dpkg -I vim-7.4.193-amd64-precise.deb
```

### <a name="install-vim-source-ubuntu"></a>Install Vim 7.4 from source (only Ubuntu)

Tested on Ubuntu 12.04. Please report any problems on different versions.

To download and compile, run:

```sh
./vim-scripts/install-vim-precise.sh
```

It will offer the option to download a tarball from the Vim website or to
clone the mercurial repository hosted on googlecode.

Vim will be compiled with "features=huge", Python and Perl support.

If system Ruby is available it will also be compiled with Ruby support.
Otherwise the script will give the option to install Ruby 1.9.3 from the
Ubuntu repositories and compile with it, or to compile without Ruby support.

It's useful to set Vim as default editor. If you wish to do so, put this
in your `~/.bashrc` or `~/.bash_profile`:

```sh
# ~/.bashrc

export EDITOR='/usr/bin/vim'
```

### <a name="install-vim-plugins"></a>Install the Vim plugins (with pathogen)

The list of essential and nice-to-have plugins is in `./vim-script/plugins.sh`.

* If a full install is required: run `vim-scripts/install-plugins.sh`.

* If a temporary install is preferred:
  - run `vim-scripts/tmp-plugins-install.sh` at the beginning of the pairing session
  - run `vim-scripts/tmp-plugins-remove.sh` when finished

Also see [read and write options](#read-write-options) if you want to enable
quick save with `CTRL-s`.

### <a name="install-tmux-source-ubuntu"></a>Install tmux 1.9 from source (only Ubuntu)

Tested on Ubuntu 12.04. Please report any problems on different versions.

To download and compile, run:

```sh
./tmux-scripts/1-tmux-install-from-source.sh
```

It will also offer to link to the provided tmux.conf file.

### <a name="tmux-conf-notes"></a>Tmux configuration notes

If you prefer to keep your own tmux.conf, it is recommended, to make the most
out of the Vim+tmux combinations, to copy at least the following sections to
the local tmux.conf (also available in the file `./rc-files/tmux.conf`):

```sh
# ~/.tmux.conf

# === Terminal compatibility ===

# Use 256 term for pretty colors
set -g default-terminal "screen-256color"
set -g terminal-overrides 'xterm:colors=256'

# Pass the keys through, especially necessary to make full use of native vim
# keymappings.
set -g xterm-keys on

# === Quick swtiching between windows ===

bind-key -n C-Space     select-window -t :+
bind-key -n M-PageDown  select-window -t :+
bind-key -n M-PageUp    select-window -t :-

# === Navigation between vim and tmux ===

# M(eta) is the Alt key both in Vim and tmux.
bind -n M-Left  run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Left)  || tmux select-pane -L"
bind -n M-Down  run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Down)  || tmux select-pane -D"
bind -n M-Up    run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Up)    || tmux select-pane -U"
bind -n M-Right run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Right) || tmux select-pane -R"

bind -n M-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Left)  || tmux select-pane -L"
bind -n M-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Down)  || tmux select-pane -D"
bind -n M-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Up)    || tmux select-pane -U"
bind -n M-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Right) || tmux select-pane -R"
```

To support correct colors in tmux, put this in your `~/.bashrc`
or `~/.bash_profile`:

```sh
# ~/.bashrc or ~/.bash_profile

if [[ -n "$TMUX" ]]; then
  export TERM=screen-256color
else
  export TERM=xterm-256color
fi
```

### <a name="update-existing-plugins"></a>Updating existing Vim plugins

Updating all the Vim plugins can be done with this oneliner:

```sh
cd ~/.vim/bundle && { \
find * -maxdepth 0 -type d | \
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

## <a name="features"></a>Features

### <a name="third-party-plugins-setup"></a>Third party plugins setup

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
  - `<leader>rq`: close Vim tmux runner opened by VimuxRunCommand
  - `<leader>rs`: interrupt any command running in the runner pane

* **Vim Ruby**
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

### <a name="language-specific-settings"></a>Language specific settings

* **Java**
  - soft tab with 4 spaces

* **Python**
  - soft tab with 4 spaces
  - use `indent` as `foldmethod`

* **golang**
  - hard tabs with 4 spaces
  - see also `./rc-files/vimrc` for the standard golang setup

* **Ruby**
  - see setup of the Vim Ruby plugin
  - see setup of the xmpfilter plugin

### <a name="miscellaneous-options"></a>Miscellaneous options

* Reduce the timeout required to recognize a command from 1000 ms (the default)
  to 350 ms.

* Remove the comment symbols when joining lines with `J`.

* Use 2-space soft tabs by defaults (it's overridden for some some languages
  with different conventions).

### <a name="miscellaneous-mappings"></a>Miscellaneous mappings

* Add a new line without going to insert mode (experimental):
  - `ALT-O` or `<leader>o`: below
  - `ALT-I` or `<leader>i`: above

Due to the difficulty to find sensible mappings, and to the impossibility to
fix the keycode for ALT-I on Mac, these mappings may be removed or changed.

* Leader is mapped to the popular `,` but `\` is still supported.

* Map `<F1>` to `<Esc>` to avoid bringing up the help by mistake.

* Map `jj`, `jk` and `kj` to `<Esc>`: popular shortcuts that allow to stay on
  the home row.<br>
  Notice that `jk` is included even though it will prevent you from quickly
  typing 'Dijkstra'.

* Toggle `paste` with `<F3>`, that disables all automatic indentation when
  pasting from the system clipboard.

* Toggle spell checking with `<F6>` as in Sublime Text.

### <a name="navigation"></a>Navigation

* Arrows are enabled to accommodate users that have different styles of
  usage.

* Moving between lines works by visible lines instead of actual lines (useful
  when wrap is enabled).

* Home key
  - pressing the home key will bring to the first non-blank character (like `^`)
  - pressing again will bring to the first column (like `0`)
  - after that it will toggle between the two positions<br>
  <br>
  A keycode fix is provided for this to work inside Tmux.

* Quickfix list
  - go to the next with `]q`, to the previous with `[q`

### <a name="mouse-support"></a>Mouse support

Mouse features are fully enabled.

### <a name="anti-typo-aliases"></a>Anti-typo command aliases

Some commands like `:w`, `:q` and similar have been aliased with the upper
case version to account for common misspellings.

### <a name="last-position-in-file"></a>Last position in file

Reopening a file the cursor will jump to the position where it was the last
time the buffer was opened.

### <a name="bubbling-lines"></a>Bubbling lines

Quickly move lines up and down with `CTRL+ArrowUp/Down` and `CTRL+k/j`.

It operates on single lines in normal mode, on multiple lines in visual mode.

Keycode fixes are provided for this to work in Tmux as well.

Note: this doesn't interfere with the copy and cut operations because it uses
the `move` command.

### <a name="buffer-enhancements"></a>Buffer enhancements

* Reuse a buffer if a file is already open.

* Switch between buffers with the same shortcuts used for tabs, for example
  in Chrome: `CTRL+PageUp/PageDown`;<br>
  on those machines where that doesn't work, `<leader>+[` and `<leader>+]` can
  be used.

* Quick close the current buffer without closing its window with `CTRL+q`, or
  `ALT+q`, or `<leader>+q`.

* Close all buffers
  - all the non-special ones with the sequence `bda` in normal mode
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

### <a name="clipboard"></a>Clipboard

* Yank to the end of the line with `Y`, to make it consistent with `C` and `D`.
  This was removed from sensible.vim.

* Copy the visual selection to the system clipboard with `CTRL+c`.<br>
  For Mac users requires additional configuration:
  <https://coderwall.com/p/j9wnfw><br>
  Note: this of course works only when working locally.

* Configuration is provided to support system clipboard in Tmux as well,
  see `./plugin/clipboard.vim`

* In visual mode, use `<leader>p` to paste from the default register without
  replacing the content of the register.
  This allows to paste multiple times the same text.

### <a name="real-delete"></a>Real delete

Vim conflates the two functionalities of deleting and cutting.

The `ALT+d` (or `<leader>d`) shortcut provided to do real deletion
(cut to the blackhole register in Vim parlance):

* current line in normal mode
* selection in visual mode

### <a name="current-directory"></a>Current directory

* Expand `%%` to the current directory in the command prompt.

* Set the working directory to the directory of the current file with
`<leader>cd`.

### <a name="read-write-options"></a>Read and write options

* As version control is effectively ubiquitous, the following are disabled
  - backup files
  - swap files
  - persistent undo

* Autowrite when switching to a different buffer or split pane, to avoid
  running tests with unsaved changes by only saving the last edited buffer.

* Quick save with `CTRL-s`. This is a very useful feature, albeit a
  controversial one. <br>
  See [Ben Orenstein's talk] (http://www.youtube.com/watch?v=SkdrYWhh-8s)
  on why it's a good idea.

  As most terminals use `CTRL-s` to suspend the output stream, this requires
  additional setup.

  Put this in your bash profile to bypass the key combination only from Vim:

```sh
vim() {
  local STTYOPTS="$(stty --save)"
  # Prevent CTRL-S from suspending the output stream
  stty stop '' -ixoff
  # Prevent CTRL-Q from waking up the output stream
  stty start '' -ixon
  command vim "$@"
  stty "$STTYOPTS"
}
```

  To always bypass these keys one can simply add this instead:

```sh
# Prevent CTRL-S from suspending the output stream
stty stop '' -ixoff
# Prevent CTRL-Q from waking up the output stream
stty start '' -ixon
```

### <a name="search-features"></a>Search features

* Highlight current word or selection with `<leader>h` (that is, search
  without jumping to the next found occurrence).

* Search visual selection with `*`.

* Smart ignore-case (consider case only if the search term contains a mix of
  of upper and lower case).

* Replace all the occurrences in a line by default, (no need to specify `g`)

* Highlighting
  - highlight results
  - clear highlighted results with `CTRL-l` (same as in "clearing" the terminal).
  - highlight matching parentheses without jumping to the closing one.

* Ignore some directories and extensions (tmp, pyc, ...).

### <a name="shell-commands-without-prompt"></a>Run shell command without prompting

This is especially useful when one wants to run a command in a diffent tmux
window or pane.

Example: to run the tests in the second pane of the first tmux window,
enter the following in the Vim prompt:

```vim
:Silent tmux send-keys -t 1.2 "bundle exec rspec spec/my_spec.rb" C-m
```

### <a name="language-specific-settings"></a>Tmux integration

A tmux.conf file is provided: `./rc-files/tmux.conf`.

The tmux installation script will prompt to link to it.

See [Tmux configuration notes](#tmux-conf-notes) for the required configuration
in `.tmux.conf`.

* Fix keycodes
  - tmux will send xterm-style keys when its xterm-keys option is on
  - this requires `set -g xterm-keys on` in the `~/.tmux.conf`
  - fix `CTRL-Page<Up/Down>` (this is required for tab-like navigation
  between buffers)
  - fix `<Home>` key
  - fix modifiers (like `CTRL-Right/Left`, `ALT-Up/Down/Left/Right`...)

* Seamless navigation between tmux and Vim with `ALT-Up/Down/Left/Right`
and `ALT-k/j/h/l`.<br>

### <a name="language-specific-settings"></a>View options

* Disable all bells.

* Use UTF-8 encoding.

* Display line numbers.

* Toggle line numbers with `CTRL-n`.

* Leave 3 visible lines and columns when scrolling.

* Create new splits bottom and right.

* Disable wrapping text.

* Autoindent.

* Highlight currently edited line.

* Allow backspace on everything.

* Disable welcome screen.

* Allow placing the cursor after the last character in block-visual mode.

* Display vertical rulers at column 81 and 101 as a reference for keeping lines
  of code at an acceptable length.

### <a name="language-specific-settings"></a>Statusbar

* Show the commands that are being executed.

* Show the current status (normal, visual...).

* Show cursor position in lower right.

* Turn statusbar green when in insert mode.

### <a name="language-specific-settings"></a>Whitespace

* Toggle trailing whitespace highlighting with `<leader>w` (off by default).

* Remove trailing whitespace on save, to avoid false conflicts in version control:
  - only for specified filetypes (see `./plugin/whitespace.vim`)
  - ensure no whitespace at the end of lines
  - ensure exactly one newline character at the end of file

### <a name="language-specific-settings"></a>`vimrc` options

* Source automatically on save.

* Enable per-directory vimrc.

* Disable unsafe commands in local vimrc files.
