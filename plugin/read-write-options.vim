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
" Save all buffers when switching between them, to avoid running tests
" with unsaved changes.
set autowrite
autocmd BufLeave,FocusLost * silent! update

" ==========================
" === Save with shortcut ===
" ==========================
"
" Save, but only if the buffer is modified.
" <http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files>
" In insert mode: stay in normal mode after saving; use <Esc>:wall<CR>a to
" return to insert mode.
inoremap <C-s> <esc>:wall<cr>
nnoremap <C-s> :wall<cr>

" === NOTE: Support for CTRL-S and CTRL-Q in the terminal ===
"
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

" ======================
" === Save with sudo ===
" ======================

" The solution at...
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work/7078429#7078429
" cnoremap w!! :w !sudo tee > /dev/null %
" ...doesn't seem to work (vim 7.4).
" Using instead
" http://www.commandlinefu.com/commands/view/1204/save-a-file-you-edited-in-vim-without-the-needed-permissions
command Sudow :execute ':silent w !sudo tee % > /dev/null' | :edit!
