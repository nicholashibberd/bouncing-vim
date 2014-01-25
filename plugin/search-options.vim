" Search for word under cursor without jumpin to next occurrence
" http://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
map <Leader>h *``

" Ignore case
set ignorecase
" ...unless one upper case letter is present in the word
set smartcase

" replace all the occurences in the line by default
set gdefault

" start searching without pressing enter
set incsearch

" highlight results
set hlsearch

" highlight matching parentheses...
set showmatch
" ...but stay out of the way (do not jump around)
set matchtime=0

" clear search results pressing space
" nnoremap <space> :nohlsearch<CR>
" NOTE: disabled because already present in vim-sensible:
" Use <C-L> to clear the highlighting of :set hlsearch.
" (taken from https://github.com/tpope/vim-sensible)
" if maparg('<C-L>', 'n') ==# ''
"   nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
" endif

" ignore some directories
set wildignore+=*/tmp/*,*.pyc
