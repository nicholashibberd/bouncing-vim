" =========================
" === Working directory ===
" =========================
" expand %% to current directory in the command prompt
" <https://github.com/chrishunt/dot-files/blob/master/.vim/vimrc>
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" cd to directory of current buffer, and print it
" <http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file>
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
