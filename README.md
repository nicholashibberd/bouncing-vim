What is it?
-----------

This is a mini vim distro, integrated with tmux.

It's a curated collection of plugins and settings, inspired by a few key
principles:

* provide a practical, "human" Vim setup
* provide as many additional features and shortcuts as possible...
* ...but try to not remove or override native Vim features

It supports temporary installation of the vim plugins by taking advantage
of pathogen.

Credits are currently given in the form of links to the original source.
Thanks to the great Vim community and to the many authors of features.

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
  * run `vim-scripts/tmp-plugins-install.sh` at the beginning of the pairing session
  * run `vim-scripts/tmp-plugins-remove.sh` when finished

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

### Bubbling lines

With `CTRL+ArrowUp` and `CTRL+ArrowDown` (single lines in normal mode,
multiple lines in visual mode).

Keycode fixes are provided for this to work in Tmux as well.

This does not interfere with the copy and cut operations.

### Buffer enhancements

* Reuse a buffer if a file is already open

* Switch between buffers with the same shortcuts used for tabs in Chrome:
  `CTRL+PageUp/PageDown`;
  on those machines where that doesn't work, `<leader>+[` and `<leader>+]` can
  be used.

* Quick close the current buffer without closing its window with `CTRL+q`, or
  `ALT+q`, or `<leader>+q`

* Close all buffers
  - all the non-special ones with `bda`
  - only the hidden ones with the `bdh` sequence in normal mode

* Copy the path of the current buffer to the system clipboard
  - relative path with the sequence `cp` in normal mode
  - full path with the sequence `cpp` in normal mode

* MiniBufExplorer customisation
  - position at the top
  - do not open by default
  - focus the buffer list with `<leader>+t`
  - toggle the buffer list with `<leader>+m`

* Buffergator plugin customisation
  - open on the right hand side
  - toggle with `<leader>+b`

### Clipboard

* Copy the visual selection to the system clipboard with `CTRL+c`
* Configuration is provided to support system clipboard in Tmux as well

### Real delete

Vim conflates the two functionalities of deleting and cutting.

The `ALT+d` (or `<leader>+d`) shortcut provided to do real deletion
(cut to the blackhole register in Vim parlance):

* current line in normal mode
* selection in visual mode

### Home key

Pressing the home key will bring to the first non-blank character (like `^`).
Pressing again will bring to the first column (like `0`).
After that it will toggle between the two positions.

A keycode fix is provided for this to work inside Tmux.

### Last position in file

Reopening a file the cursor will jump to the position where it was the last
time the buffer was opened.

### Mouse support

Mouse features are fully enabled.
