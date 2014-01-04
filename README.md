What is it?
-----------

A small, opinionated yet unobtrusive vim distro, tightly integrated with tmux.

It supports temporary installation by taking advantage of pathogen.

Installing
----------

Installation of Vim and tmux supports Ubuntu. The plugin itself uses pathogen.

### Install Vim from source (on Ubuntu)

### Install tmux from source

Requirements
------------

### Environment

* Ubuntu 12.04 (but it mostly works on Mac too)
* Tmux 1.8
* Vim 7.4
* git
* vim compiled with support for:
  - Python
  - Ruby
  - clipboard
  - X11
* pathogen

### Other plugins

Some (very) popular plugins are assumed to be installed via pathogen.
* Download the helper scripts at <https://github.com/lucabelmondo/vim-luke-install/>
* If a full install is required: run `install-plugins.sh`.
* If a temporary install is preferred:
  * run `tmp-plugins-install.sh` at the beginning of the pairing session
  * run `tmp-plugins-remove.sh` when finished

If using pathogen and plugins are not installed as git submodules (as in this
case), a oneliner can be used to update all the plugins

```sh
  cd ~/.vim/bundle; \
  ls -lA | \
    grep ^d | \
    sed -r 's/.+[[:digit:]]{2}:[[:digit:]]{2}\s*(.+)/\1/g' | \
    while read repo; do \
      echo "---- $repo ----"; \
      cd $repo; \
      git pull origin master; \
      cd ..; \
      echo; \
    done; \
  cd -
```

### Tmux configuration

Add the following to `.tmux.conf` to enable seamless navigation between vim and
tmux windows.

```sh
# Enable 256 colorschemes
set -g default-terminal "screen-256color"
# Pass modifier keys through tmux to vim
set -g xterm-keys on
# Quick window selection
bind-key -n C-Space select-window -t :+
bind-key -n M-PageDown select-window -t :+
bind-key -n M-PageUp select-window -t :-
# Navigate seamlessly between vim splits and tmux panes
bind -n M-Left run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Left) || tmux select-pane -L"
bind -n M-Down run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Down) || tmux select-pane -D"
bind -n M-Up run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Up) || tmux select-pane -U"
bind -n M-Right run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Right) || tmux select-pane -R"
```

More info at <https://github.com/lucabelmondo/dotfiles/blob/master/tmux.conf>.

Features
--------

> (incomplete list, this README is a work in progress)

### Bubbling lines

With `CTRL+ArrowUp` and `CTRL+ArrowDown` (single lines in normal mode,
multiple lines in visual mode).

Keycode fixes are provided for this to work in Tmux as well.

### Buffer enhancements

* Reuse a buffer if a file is already open
* Switch between buffers with the same shortcuts used for tabs in Chrome:
  `CTRL+PageUp/PageDown`;
  on those machines where that doesn't work, `<leader>+[` and `<leader>+]` can
  be used.
* Quick close the current buffer without closing its window with `CTRL+q`, or
  `ALT+q`, or `<leader>+q`
* Close all buffers
  * all the non-special ones with `bda`
  * only the hidden ones with the `bdh` sequence in normal mode
* Copy the path of the currenct buffer
  * relative path with the sequence `cp` in normal mode
  * full path with the sequence `cpp` in normal mode
* MiniBufExplorer plugin (tab-like list of buffers)
  - position at the top
  - focus the buffer list with `<leader>+t`
  - toggle the buffer list with `<leader>+m`
* Buffergator plugin (interactive list of buffers)
  - open on the right hand side
  - toggle with `<leader>+b`

> A lot of other features are already implemented, this README will be
> updated to illustrate all of them.

### Clipboard

* Copy the visual selection to the system clipboard with `CTRL+c`
* Configuration is provided to support system clipboard in Tmux as well

### Real delete

Vim collapses the two functionalities of deleting and cutting.

The `ALT+d` shortcut is provided to do real deletion (cut to the blackhole
register in Vim parlance):
- current line in normal mode
- selection in visual mode

### Home key

Pressing the home key will bring to the first non-blank character.
Pressing again will bring to the first column, and then it will toggle between
the two positions.

A keycode fix is provided for this to work inside Tmux.

### Last position in file

Reopening a file the cursor will jump to the position where it was the last
time the buffer was opened.

### Mouse support

Mouse features are fully enabled.
