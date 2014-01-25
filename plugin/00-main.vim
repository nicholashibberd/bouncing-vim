" Credits: originally based on https://github.com/DawidJanczak/.vim/blob/master/.vimrc

" ==================
" === Leader key ===
" ==================
" <http://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader>
" http://stackoverflow.com/questions/8395531/how-do-i-map-multiple-leader-keys-in-vim
"
" Map leader key to the customary comma...
let mapleader=','
" ...without overriding it
nmap \ ,
vmap \ ,

" =======================
" === Misc keybinding ===
" =======================

" Map F1 key (main vim help) to ESC to avoid bringing it up by mistake.
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap <F1> <ESC>

" Go from insert mode to normal mode with 'jj'
inoremap jj <ESC>

" toggle spell checking with <F6>
nnoremap <F6> :setlocal spell!<CR>
inoremap <F6> :setlocal spell!<CR>
vnoremap <F6> :setlocal spell!<CR>

" ====================
" === Misc options ===
" ====================

" reduce the default command timeout (1000)
set timeoutlen=350

" Use 2-space soft tabs by defaults (it's overriden for some some languages
" with different conventions).
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" ======================
" === Format options ===
" ======================

set pastetoggle=<F3> " disable auto format when pasting from system clipboard

if version >= 704
  " delete comment leader when joining lines using J
  set formatoptions+=j
endif

" =============
" === CtrlP ===
" =============

" Taken from CtrlP documentation
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.*(git|hg|svn|bundle|bin|bbin)$',
  \ 'file': '\v\.(exe|so|dll|class|pyc)$',
  \ }
  " \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',

" ===========
" === Ack ===
" ===========
" launch ack without argument with leader+a
nnoremap <Leader>a :Ack!<space>

" use the silver searcher instead of ack, if available
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" ================
" === NERDTree ===
" ================
" Shortcut to open/close NERDTree
map <Leader>n :NERDTreeToggle<CR>
" Highlight the current buffer (think of 'find')
map <Leader>f :NERDTreeFind<CR>
" http://superuser.com/questions/184844/hide-certain-files-in-nerdtree
let NERDTreeIgnore = ['\.pyc$', '\.class$']
let NERDTreeMinimalUI=1
" let NERDTreeMouseMode=2 " single click to toggle dirs, dblclick to open files
" let NERDTreeQuitOnOpen=1 " avoid clutter, close NERDTree after opening a file

" Prevent NERDTree from opening a new split-window
" <http://stackoverflow.com/questions/8323666/make-nerdtree-never-open-a-third-window>
" If the last focused buffer is modified and unsaved, it will still open a new split
set buftype=

" ==========================
" === vimux - vim + tmux ===
" ==========================
" Requires vim compiled with ruby support.

" Run the current file with rspec
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" Prompt for a command to run
map <Leader>rp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>rr :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>ri :VimuxInspectRunner<CR>
" Close all other tmux panes in current window
map <Leader>rx :VimuxClosePanes<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>rq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>rs :VimuxInterruptRunner<CR>

" ================
" === vim-ruby ===
" ================
" turn on ruby evaluation for c-x c-o expansion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
" Highlight ruby operators (`/`, `&&`, `*`...)
let g:ruby_operators = 1

" ==================================
" === Language specific settings ===
" ==================================

" --- Java
autocmd FileType java setlocal ts=4 sts=4 sw=4

" --- Python
" autocmd FileType python setlocal ts=4 sts=4 sw=4
" autocmd FileType python setlocal foldmethod=indent " it works pretty badly anyway

" --- Go
autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab

" ======================
" === ruby xmpfilter ===
" ======================
" Gvim
nmap <buffer> <M-r> <Plug>(xmpfilter-run)
xmap <buffer> <M-r> <Plug>(xmpfilter-run)
imap <buffer> <M-r> <Plug>(xmpfilter-run)

nmap <buffer> <M-m> <Plug>(xmpfilter-mark)
xmap <buffer> <M-m> <Plug>(xmpfilter-mark)
imap <buffer> <M-m> <Plug>(xmpfilter-mark)

" Terminal
nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)

nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)
