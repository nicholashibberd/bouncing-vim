" ====================
" === Bubble lines ===
" ====================
" http://reefpoints.dockyard.com/2013/09/26/vim-moving-lines-aint-hard.html
" Modified to avoid automatic reindenting

" Normal mode
nnoremap <C-Down> :m .+1<CR>
nnoremap <C-Up> :m .-2<CR>
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>

" Insert mode
inoremap <C-Down> <ESC>:m .+1<CR>gi
inoremap <C-Up> <ESC>:m .-2<CR>gi
inoremap <C-j> <ESC>:m .+1<CR>gi
inoremap <C-k> <ESC>:m .-2<CR>gi

" Visual mode
vnoremap <C-Down> :m '>+1<CR>gv
vnoremap <C-Up> :m '<-2<CR>gv
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv
