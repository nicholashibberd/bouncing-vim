" Credits: originally based on https://github.com/DawidJanczak/.vim/blob/master/.vimrc

" ==================================
" === Autowrite, Backup and Undo ===
" ==================================
" http://albertomiorin.com/blog/2012/12/10/autoread-and-autowrite-in-vim/
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost

set hidden " allow switching between buffers with unsaved changes
set nobackup
set noswapfile
set nowritebackup

" Auto-reload buffers when file changed on disk (doesn't work in reality)
set autoread

" ===================
" === Tabulations ===
" ===================
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" ====================
" === View options ===
" ====================

set noerrorbells visualbell t_vb=    " Disable all bells
set encoding=utf-8                   " Encoding
set number                           " display line numbers
nnoremap <C-n> :setlocal number!<CR> " Toggle line numbers
set scrolloff=3                      " number of lines visible when scrolling
set sidescroll=3
set sidescrolloff=3
set splitright                       " position of the new split panes
set splitbelow
set nowrap
set autoindent                       " remember indent after going to the next line
set showcmd                          " show command that is being entered in the lower right
set showmode                         " show current mode (e.g. input, visual)
set cursorline                       " highlight currently edited line
set ruler                            " show cursor position in lower right
set backspace=indent,eol,start       " Allow extended backspace behaviour
set pastetoggle=<F3>                 " disable auto format when pasting from system clipboard
set virtualedit=block                " allow placing the cursor after the last char
if exists('+colorcolumn')
  set colorcolumn=81,101              " display vertical rulers for line length
                                      " http://whiletruecode.com/post/adding-a-vertical-ruler-to-vim
endif


" ================================
" === Search visually selected ===
" ================================
" <http://vim.wikia.com/wiki/Search_for_visually_selected_text>
" <http://vim.wikia.com/wiki/VimTip171>
" Search for selected text, forwards or backwards. It is case insensitive, and
" any whitespace is matched ('hello\nworld' matches 'hello world')
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" =================================
" === Replace visually selected ===
" =================================

" http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
" By pressing ctrl + r in the visual mode you will be prompted to enter text
" to replace with. Press enter and then confirm each change.
vnoremap <C-r> "hy:%s/<C-r>h//gc<Left><Left><Left>

" ========================================
" === External commands without prompt ===
" ========================================
" <http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts>
" Example
" :Silent tmux send-keys -t 1.2 "bundle exec rspec spec/my_spec.rb" C-m
" => run the tests in the second pane of the first tmux window, enter
" Notes
" - when running a tmux command, the actual command must be quoted;
" - bash aliases cannot be used; see snippets for more on this;
command! -nargs=1 Silent
      \ | execute ':silent !'.<q-args>
      \ | execute ':redraw!'

" =======================
" === Misc keybinding ===
" =======================

" This was removed from vim-sensible.
" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

" gp selects the just changed or pasted text
" <http://vim.wikia.com/wiki/Selecting_your_pasted_text>
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" ======================
" === Format options ===
" ======================

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
nnoremap <Leader>m :MBEToggle<CR>
vnoremap <Leader>m :MBEToggle<CR>

" =================================================================
" === Experimental stuff from http://zzapper.co.uk/vimtips.html ===
" =================================================================

" visual searching
" search for visually highlighted text
vmap // y/<C-R>"<CR>
" with spec chars
vmap <silent> //    y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
