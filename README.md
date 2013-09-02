What is it?
-----------

A collection of VIM customisations that I use every day, providing features
that helped me in the transition from Sublime Text.

It also help me in remote pairing sessions with a temporary install.

Credits are given in the form of a link the original resource.

Usage
-----

### Installing the other required plugins

While not strictly necessary, a few other popular plugins are assumed.

* Download the helper scripts at <https://github.com/lucabelmondo/vim-luke-install/>
* If a full install is required: run `install-plugins.sh`.
* If a temporary install is preferred:
  * run `tmp-plugins-install.sh` at the beginning of the pairing session
  * run `tmp-plugins-remove.sh` when finished

### Tmux configuration

Add the following to `.tmux.conf` to enable better integration between vim and
tmux.

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

Requirements
------------

While not strictly a requirement, it assumes that some popular plugins are
installed via pathogen.
* git
* vim with support for:
  * Python
  * Ruby
  * clipboard
  * X11
* pathogen

It's used every day on:

* Tmux 1.8
* Vim 7.4
* Ubuntu 12.04

It also relies on some tmux configuration, that can be found at
<https://github.com/lucabelmondo/dotfiles>.

I tried to avoid overriding built-in and popular setups and keybindings I was
aware of and to add rather than change functionality.

However if you find some conflict with existing functionalities, please do let
me know, so that over time I can make the plugin as unobtrusive as possible.

Thanks for installing!
