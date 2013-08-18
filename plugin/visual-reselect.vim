" gp selects the just changed or pasted text
" <http://vim.wikia.com/wiki/Selecting_your_pasted_text>
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
