" Search basics

" Center the next/previous search result
nmap n nzz
nmap N Nzz

" Automatically add \v when searching so that regexp acts more like in perl
nnoremap / /\v
vnoremap / /\v
" Ignore case
set ignorecase
" ...unless one upper case letter is present in the word
set smartcase
" replace all the occurences by default
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
nnoremap <space> :nohlsearch<CR>
" ignore some directories
set wildignore+=*/tmp/*,*.pyc
