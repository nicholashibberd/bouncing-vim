" =================
" === Clipboard ===
" =================
" <http://devinvenable.blogspot.co.uk/2009/12/save-with-ctrl-s-using-vim-and.html>
" <http://vim.wikia.com/wiki/Accessing_the_system_clipboard>
" Requires that Vim has been compiled with clipboard and X11 support.
" On Linux => choose the variant vim-gnome
vnoremap <C-c> "+y
