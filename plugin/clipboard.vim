" =================
" === Clipboard ===
" =================
" <http://devinvenable.blogspot.co.uk/2009/12/save-with-ctrl-s-using-vim-and.html>
" <http://vim.wikia.com/wiki/Accessing_the_system_clipboard>
" Requires that Vim has been compiled with clipboard and X11 support.
" On Linux => choose the variant vim-gnome or compile from source
" This is nice because gives best of both worlds.
vnoremap <C-c> "+y
" The corresponding setting for pasting is not needed because normally
" already supported by the terminal, and it would be difficult to find a
" sensible keybinding that doesn't conflict with existing ones.
" Alternatively, it's also possible to always use the system clipboard
" by default: http://vim.wikia.com/wiki/Accessing_the_system_clipboard
" set clipboard=unnamedplus
" For Mac users requires additional configuration:
" https://coderwall.com/p/j9wnfw

" NOTE: TMUX SUPPORT
" ------------------
" To enable system clipboard in tmux as well:
" # http://blog.sanctum.geek.nz/vi-mode-in-tmux/
" # http://www.drbunsen.org/the-text-triumvirate/#tmux
" set-window-option -g mode-keys vi
" bind-key -t vi-copy 'v' begin-selection
" # bind-key -t vi-copy 'y' copy-selection
" # http://robots.thoughtbot.com/post/55885045171/tmux-copy-paste-on-os-x-a-better-future
" bind-key -t vi-copy 'y' copy-pipe "xsel --clipboard --input"
" # bind-key -t vi-copy 'p' paste-buffer
" unbind p
" bind p paste-buffer
"
" # give 'v' to the user that still needs to go to the previous buffer
" bind v previous-window
