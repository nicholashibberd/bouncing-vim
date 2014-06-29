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
  - [Tmux integration](#tmux-integration)
  - [View options](#view-options)
  - [Statusbar](#statusbar-options)
  - [Whitespace](#whitespace-options)
  - [`vimrc` options](#vimrc-options)

## <a name="plugins-list"></a>Third party plugins

Install all the essential plugins with:
`./vim-scripts/install-plugins`

Install all the plugins (including the nice-to-have's) with:
`./vim-scripts/install-plugins-with-nice-to-haves`

To install without prompts, use `./vim-scripts/install-plugins-noprompt` or
`./vim-scripts/install-plugins-noprompt-with-nice-to-haves`.
This can be useful when installing from scripts. You will need to pass the
path to the home directory in this case.

To install only the essentials, and only temporarily:
* install with: `./vim-scripts/tmp-plugins-install`.
* remove with: `./vim-scripts/tmp-plugins-remove`.

### <a name="essential-plugins"></a>Essentials

Functionality

* [Ack-vim] (https://github.com/mileszs/ack.vim) - Run [ack] (http://beyondgrep.com/)
  from Vim, and shows the results in a split window.
* [Buffergator] (https://github.com/jeetsukumaran/vim-buffergator) - Vim plugin
  to list, select and switch between buffers.
* [commentary.vim] (https://github.com/tpope/vim-commentary) - Comment stuff out.
* [Ctrl-P] (https://github.com/kien/ctrlp.vim) - Full path fuzzy file, buffer,
  mru, tag, ... finder for Vim, written in pure Vimscript.
* [fugitive.vim] (https://github.com/tpope/vim-fugitive) - A Git wrapper so
  awesome, it should be illegal.
* [MiniBufExplorer] (https://github.com/fholgado/minibufexpl.vim) -
  Elegant buffer explorer, takes very little screen space.
* [Multiple cursors] (https://github.com/terryma/vim-multiple-cursors) -
  Sublime Text style multiple selections for Vim.
* [NERDTree] (https://github.com/scrooloose/nerdtree) - Explore the filesystem
  in a hierarchical tree structure and open files and directories.
* [Sensible] (https://github.com/tpope/vim-sensible) - A universal set of
  defaults that (hopefully) everyone can agree on.
* [Supertab] (https://github.com/ervandew/supertab) - Perform all your Vim insert
  mode completions with Tab.
* [Tabular] (https://github.com/godlygeek/tabular) - Vim script for text
  filtering and alignment.
* [Surround] (https://github.com/tpope/vim-surround) - Edit parentheses,
  brackets, quotes, XML tags, and more in pairs.
* [Vimux] (https://github.com/benmills/vimux) - Easily interact with tmux from Vim.
* [repeat.vim] (https://github.com/tpope/vim-repeat) - enable repeating supported plugin maps with "."

Language support

* [Coffeescript] (https://github.com/kchmck/vim-coffee-script) - Adds
  CoffeeScript support to Vim. It covers syntax, indenting, compiling, and more.
* [Tim Pope's Markdown] (https://github.com/tpope/vim-markdown), particularly
  for its ability to highlight code blocks in the respective language.
* [Mustache] (https://github.com/mustache/vim-mustache-handlebars) - A Vim plugin for
  working with mustache and handlebars templates.
* [rails.vim] (https://github.com/tpope/vim-rails) - Ruby on Rails power tools.
* [Ruby] (https://github.com/vim-ruby/vim-ruby) - Vim configuration files
  for editing and compiling Ruby within Vim.

Colorschemes

* [Agnostic] (https://github.com/ygt-mikekchar/agnostic) - A Vim colour scheme
  that allows to choose your own colours.
* [Molokai] (https://github.com/tomasr/molokai) - A Vim port of the monokai
  theme for TextMate.
* [Solarized] (https://github.com/altercation/vim-colors-solarized) - Precision
  colors for machines and people.

### <a name="nice-to-have-plugins"></a>Nice-to-have's

These are only installed when running the full install: `./vim-scripts/install-plugins`

* [Python Syntax] (https://github.com/hdima/python-syntax) - Python syntax
  highlighting script for Vim.
* [Ultisnips] (https://github.com/SirVer/ultisnips) - An implementation
  of TextMates Snippets for the Vim Text Editor. Requires Vim compiled with
  Python support.
* [HiLinkTrace] (https://github.com/gerw/vim-HiLinkTrace) - Get the color of the
  text object under the cursor.
* [vim-ruby-xmpfilter] (https://github.com/t9md/vim-ruby-xmpfilter) - Helper
  for ruby's xmpfilter or seeing_is_believing. Evaluates Ruby code inline and
  print the result as a comment at the end of the line.
* [vim-go](https://github.com/fatih/vim-go) - Full featured Go development
  environment. This plugin will create the executable it needs, if the
  golang runtime is available, the first time Vim is run. This might take a
  couple of minutes.
* [mediawiki syntax](https://github.com/chikamichi/mediawiki.vim) - Syntax
highlighting for MediaWiki-based projects, such as Wikipedia.
* [Puppet] (https://github.com/rodjek/vim-puppet)
* [Dockerfile] (https://github.com/ekalinin/Dockerfile.vim)

Colorschemes:

* [Noctu] (https://github.com/noahfrederick/vim-noctu) - A Vim color scheme for
  16-color terminals.
* [Base16] (https://github.com/chriskempson/base16-vim) - Color schemes for hackers.

## <a name="installing"></a>Installing

Installation of tmux supports Ubuntu (tested on 12.04).

The plugins use pathogen.

It's useful to set Vim as default editor. If you wish to do so, put this
in your `~/.bashrc` or `~/.bash_profile`:

```sh
# ~/.bashrc

export EDITOR='/usr/bin/vim'
```

### <a name="install-vim-plugins"></a>Install the Vim plugins (with pathogen)

The list of essential and nice-to-have plugins is in `./vim-script/plugins`.

*Full install*: run `./vim-scripts/install-plugins`.

You will be prompted to use the provided `vimrc` and `tmux.conf`, your files
will be backed up.

If you chose to link to the `vimrc`, you can still add custom configuration
in a `~/.vimrc.after` file that will be loaded automatically.

*Temporary install*:

- run `./vim-scripts/tmp-plugins-install` at the beginning of the pairing session
- run `./vim-scripts/tmp-plugins-remove` when finished

In both cases:

- the plugins will be cloned from github into `~/.vim/bundle/`
- existing plugins will be skipped (based on the name of the github repo)

Also see [read and write options] (#read-write-options) if you want to enable
quick save with `CTRL-s`.

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
  - use `ag` (the silver searcher) as search engine, to avoid caching on
    first use

* **Ack**
  - launch `:Ack!` with `<leader>a`
  - use [Ag The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
    if available, to go even faster
  - use a customised command to ignore some patterns to account for
    missing `~/.ackrc` and `~/.agignore`

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
  - open at the bottom to be consistent with default Ctrl-P behaviour
  - set size to 10 rows
  - toggle with `<leader>+b`

### <a name="language-specific-settings"></a>Language specific settings

* **Java**
  - soft tab with 4 spaces

* **Python**
  - soft tab with 4 spaces
  - use `indent` as `foldmethod`

* **golang**
  - hard tabs with 4 spaces
  - uses the fatih/vim-go plugin
  - prevents error for automatic compilation of the plugin's binaries
    when golang is not installed

* **markdown**
  - highlight code blocks in the respective language

* **Ruby**
  - see setup of the Vim Ruby plugin
  - see setup of the xmpfilter plugin

### <a name="miscellaneous-options"></a>Miscellaneous options

* Reduce the timeout required to recognize a command from 1000 ms (the default)
  to 350 ms.

* Joining lines:
  - remove the comment symbols when joining lines with `J`
  - only use one space after punctation ([wiki] (http://en.wikipedia.org/wiki/Sentence_spacing#Typography))

* Use 2-space soft tabs by defaults (it's overridden for some some languages
  with different conventions).

### <a name="miscellaneous-mappings"></a>Miscellaneous mappings

* Add a new line without going to insert mode (experimental):
  - `ALT-O` or `<leader>o`: below
  - `ALT-I` or `<leader>i`: above

Due to the difficulty to find sensible mappings, and to the impossibility to
fix the keycode for ALT-I on Mac: these mappings may be removed or changed.

* Leader is mapped to the popular `,` but `\` is still supported.

* Map `<F1>` to `<Esc>` to avoid bringing up the help by mistake.

* Map `jj`, `jk` and `kj` to `<Esc>`: popular shortcuts that allow to stay on
  the home row.<br>
  Notice that `jk` is included even though it will prevent you from quickly
  typing 'Dijkstra'.

* Toggle `paste` with `<F3>`, that disables all automatic indentation when
  pasting from the system clipboard.

* Toggle spell checking with `<F6>` as in Sublime Text.

* Quickfix list
  - open in vertical and horizontal splits with `<C-v>` and `<C-s>`

* Edit new file in new path with `:EP` ("edit with path"). You can also use
  `<C-y>` once you are in CtrlP.

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
  - all the non-special ones with `<Leader>ca` in normal mode
  - only the hidden ones with `<Leader>ch` in normal mode

* Copy the path of the current buffer to the system clipboard
  - relative path with the sequence `cp` in normal mode
  - full path with the sequence `cpp` in normal mode

* MiniBufExplorer customisation
  - position at the top
  - do not open by default
  - focus the buffer list with `<leader>t` (open if necessary)
  - toggle the buffer list with `<leader>m`

* Buffergator plugin customisation
  - open at the bottom to be consistent with default Ctrl-P behaviour
  - set size to 10 rows
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

* Write with sudo with `:Sudow`.

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

**Search in files and external grep programs**

People have different habits and opinions when it comes to search within
multiple files.

ack.vim is very popular but not with everyone due the need to install or
compile additional packages.

Sometimes the plugins ack.vim or fugitive (which provides `:Ggrep`) are not
available.

In these cases some minimal search helpers can be useful.

* Use external grep programs (for the native `:grep` command):
  - if available use `ag` or `ack`
  - otherwise use a more generally useful custom `grep` command

* Provide commands which will execute the search and open the results in
  the quickfix list:
  - `:G` command (shortcut `\\`) will run `:grep`;
  - `:GG` command (shortcut `\\\`) will run `:!git grep`; if one or more
    arguments are provided it will use them, otherwise it will search for
    the current word;

* Provide a precompiled `noautocmd vimgrep` (shortcur `<Leader>-s`) command
  that searches for the current word in files with the same extension as
  the current one.

Plans for these features:

- add the capability to search implicitly for the current word to `:G`
- add the capability to seach for the visually selected text to both `:G` and `:GG`
- make the `vimgrep` helper more fault-tolerant

### <a name="shell-commands-without-prompt"></a>Run shell command without prompting

This is especially useful when one wants to run a command in a diffent tmux
window or pane.

Example: to run the tests in the second pane of the first tmux window,
enter the following in the Vim prompt:

```vim
:Silent tmux send-keys -t 1.2 "bundle exec rspec spec/my_spec.rb" C-m
```

### <a name="tmux-integration"></a>Tmux integration

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

### <a name="view-options"></a>View options

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

### <a name="statusbar-options"></a>Statusbar

* Show the commands that are being executed.

* Show the current status (normal, visual...).

* Show cursor position in lower right.

* Turn statusbar green when in insert mode.

### <a name="whitespace-options"></a>Whitespace

* Toggle trailing whitespace highlighting with `<leader>w` (off by default).

* Remove trailing whitespace on save, to avoid false conflicts in version control:
  - only for specified filetypes (see `./plugin/whitespace.vim`)
  - ensure no whitespace at the end of lines
  - ensure exactly one newline character at the end of file

### <a name="vimrc-options"></a>`vimrc` options

* Source automatically on save.

* Enable per-directory vimrc.

* Disable unsafe commands in local vimrc files.

* Additional configuration can be put in `~/.vimrc.after` that will be
loaded automatically if present.
