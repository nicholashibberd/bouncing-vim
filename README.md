What is it?
-----------

A collection of customisations that I use every day, providing helpful
features in the transition to Vim.

With a temporary install it is also useful in remote pairing sessions.

It tries wherever possible to avoid overriding built-in and popular setups and
keybindings, and to add rather than change functionality.

However if you find some conflict with existing functionalities, please do let
me know, so that over time I can make the plugin as unobtrusive as possible.

Credits are given in the form of links in the code.

Thanks for installing!

Installing
----------

See:

* <https://github.com/lucabelmondo/vim-luke-install> for installing Vim from
source on Ubuntu and the other required plugins
* <https://github.com/lucabelmondo/tmux-setup> for installing Tmux from source
on Ubuntu

Install this plugin with pathogen.

Requirements
------------

### Environment

* Ubuntu 12.04 (but it mostly works on Mac too)
* Tmux 1.8
* Vim 7.4
* git
* vim compiled with support for:
  * Python
  * Ruby
  * clipboard
  * X11
* pathogen

### Other plugins

Some (very) popular plugins are assumed to be installed via pathogen.
* Download the helper scripts at <https://github.com/lucabelmondo/vim-luke-install/>
* If a full install is required: run `install-plugins.sh`.
* If a temporary install is preferred:
  * run `tmp-plugins-install.sh` at the beginning of the pairing session
  * run `tmp-plugins-remove.sh` when finished

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

### Buffer enhancements

* Reuse a buffer if a file is already open
* Switch between buffers with the same shortcuts used for tabs in Chrome:
  `CTRL+PageUp/PageDown`;
  on those machines where that doesn't work, `<leader>+[` and `<leader>+]` can
  be used.
* Quick close the current buffer without closing it window with `CTRL+q`, or
  `ALT+q`, or `<leader>+q`
* Close all the invisible buffers with the `bda` sequence in normal mode
* Copy the full path of the current buffer to the clipboard, with the sequence
  `cp` in normal mode
* MiniBufExplorer plugin (tab-like list of buffers)
  - position at the top
  - focus the buffer list with `<leader>+t`
  - toggle the buffer list with `<leader>+m`
* Buffergator plugin (interactive list of buffers)
  - open on the right hand side
  - toggle with `<leader>+b`

> A lot of other features are already implemented, this README will be
> updated to illustrate all of them.
