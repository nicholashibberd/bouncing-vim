" gp selects the just changed or pasted text
" <http://vim.wikia.com/wiki/Selecting_your_pasted_text>
" (it uses `gp` in the wiki, but conflicts with standard gp, which is paste
" going to the end of the pasted text)
nnoremap <expr> <Leader>v '`[' . strpart(getregtype(), 0, 1) . '`]'
