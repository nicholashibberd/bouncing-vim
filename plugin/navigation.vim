" ================
" === Home key ===
" ================
" <http://vim.wikia.com/wiki/Smart_home>
" First fix the home key for tmux, see section
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" ====================================
" === Up and down by visible lines ===
" ====================================

" j/k and up/down work on visible lines instead of actual lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" ================================
" === Quickfix list navigation ===
" ================================
" It's also useful with plugins like 'ack.vim'
nmap [q :cprevious<CR>
nmap ]q :cnext<CR>
