" Credits: originally based on https://github.com/DawidJanczak/.vim/blob/master/.vimrc

" =======================
" === Misc keybinding ===
" =======================

" This was removed from vim-sensible.
" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

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

let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|bundle)$'

" ===========
" === Ack ===
" ===========
" launch ack without argument with leader+a
nnoremap <Leader>a :Ack!<space>

" ================
" === NERDTree ===
" ================
map <Leader>n :NERDTreeToggle<CR>
" Highlight the current buffer
map <Leader>f :NERDTreeFind<CR>
" http://superuser.com/questions/184844/hide-certain-files-in-nerdtree
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeMinimalUI=1

" Prevent NERDTree from opening a new split-window
" <http://stackoverflow.com/questions/8323666/make-nerdtree-never-open-a-third-window>
" It's nice in theory but it seems to work pretty randomly.
set buftype=

" ===================
" === Buffergator ===
" ===================
let g:buffergator_viewport_split_policy='R'
noremap <Leader>b :BuffergatorToggle<CR>

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

" ==================================
" === Language specific settings ===
" ==================================

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

" =======================
" === MiniBufExplorer ===
" =======================
" Put new window above current or on the left for vertical split
let g:miniBufExplBRSplit = 0
let g:miniBufExplUseSingleClick = 1
nnoremap <Leader>m :MBEFocus<CR>
vnoremap <Leader>m :MBEFocus<CR>
nnoremap <Leader>t :MBEToggle<CR>
vnoremap <Leader>t :MBEToggle<CR>
