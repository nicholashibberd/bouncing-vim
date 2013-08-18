" ================
" === Home key ===
" ================
" <http://vim.wikia.com/wiki/Smart_home>
" First fix the home key for tmux, see section
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>
