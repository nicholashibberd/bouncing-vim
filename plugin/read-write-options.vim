" ==================================
" === Autowrite, Backup and Undo ===
" ==================================
" http://albertomiorin.com/blog/2012/12/10/autoread-and-autowrite-in-vim/
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost

set hidden " allow switching between buffers with unsaved changes
set nobackup
set noswapfile
set nowritebackup

" Auto-reload buffers when file changed on disk (does not always work in reality)
set autoread
set autowrite

" ==========================
" === Save with shortcut ===
" ==========================
" <http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files>
" Save, but only if the buffer is modified.
inoremap <C-s> <esc>:wall<cr>a
" other good option: save in the middle of typing and automatically confirm (second CR)
" inoremap <C-s> <c-o>:Update<CR><CR>
nnoremap <C-s> :wall<cr>

" ===========================================================
" === NOTE: Support for CTRL-S and CTRL-Q in the terminal ===
" ===========================================================
" Normally CTRL-S and CTRL-Q suspend and wake up the terminal output in
" terminal emulators (respectively freezing and unfreezing).
" Put this function in the .bashrc to allow instead passing the key combo
" through to vim.
"
" vim() {
"   local STTYOPTS="$(stty --save)"
"   stty stop '' -ixoff # pass CTRL-S
"   stty start '' -ixon # pass CTRL-Q
"   command vim "$@"
"   stty "$STTYOPTS"
" }
