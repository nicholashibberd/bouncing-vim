" Credits: originally based on https://github.com/DawidJanczak/.vim/blob/master/.vimrc

" =========================
" === Per project vimrc ===
" =========================
" <http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/>

set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

" =======================================
" === Autoreload ~/.vimrc when edited ===
" =======================================

" <https://github.com/bryankennedy/vimrc/blob/master/vimrc>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" ============================
" === Fix keys inside tmux ===
" ============================

" This requires (besides some faith and luck)...
"
" 1 - ...to set the TERM correctly in bashrc
"
" if [[ -n "$TMUX" ]]; then
"   export TERM=screen-256color
" else
"   export TERM=xterm-256color
" fi
"
" 2 - ...to set xterm key forwarding in tmux.conf
" set -g xterm-keys on
"
" <http://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux/402084#402084>
" <http://denihow.com/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux/>
" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
  map [6;5~ <C-Pagedown>
  map [5;5~ <C-PageUp>

  exec "set <Home>=\e[1~"

  exec "set <xUp>=\e[1;*A"
  exec "set <xDown>=\e[1;*B"
  exec "set <xRight>=\e[1;*C"
  exec "set <xLeft>=\e[1;*D"
endif

" ============
" === Save ===
" ============
" http://vimdoc.sourceforge.net/htmldoc/usr_40.html#40.2
command W   w
command Wa  wa
command WA  wa
command Q   q
command Qa  quitall
command QA  quitall
command Wq  wq
command Wqa wqa

" ===============
" === Buffers ===
" ===============

" If a buffer is already open in another window, jump to it instead of opening a new window.
set switchbuf=useopen

" Different keybindings for people with different terminals.
" 'close the current buffer without closing the window' (terrific solution)
" <http://stackoverflow.com/a/8585343/417375>
nnoremap <C-q> :bp<bar>sp<bar>bn<bar>bd<cr>
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>

" First, fix ALT for gnome terminal
map q  <A-q>
" Second, the actual mapping
" ...current line in normal and insert mode
nnoremap <A-q> :bp<bar>sp<bar>bn<bar>bd<cr>

" Switch buffers...
" ...toggle between current and previous
nnoremap <leader><space> :b#<cr>
" ...next
nnoremap <C-Pagedown> :bn<cr>
inoremap <C-Pagedown> :bn<cr>
" ...previous
nnoremap <C-Pageup>   :bp<cr>
inoremap <C-Pageup>   :bp<cr>

" ...without Ctrl key, for mac users
nnoremap <leader>] :bn<cr>
inoremap <leader>] :bn<cr>
nnoremap <leader>[ :bp<cr>
inoremap <leader>[ :bp<cr>

" ================
" === Home key ===
" ================
" <http://vim.wikia.com/wiki/Smart_home>
" First fix the home key for tmux, see section
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" =================
" === Clipboard ===
" =================
" <http://devinvenable.blogspot.co.uk/2009/12/save-with-ctrl-s-using-vim-and.html>
" <http://vim.wikia.com/wiki/Accessing_the_system_clipboard>
" Requires that Vim has been compiled with clipboard and X11 support.
" On Linux => choose the variant vim-gnome
vnoremap <C-c> "+y

" =================================================
" === Move between split windows AND tmux panes ===
" =================================================
"
" http://robots.thoughtbot.com/post/53022241323/seamlessly-navigate-vim-and-tmux-splits
" https://github.com/christoomey/vim-tmux-navigator
" https://gist.github.com/mislav/5189704
" https://gist.github.com/mislav/5189704/revisions
"
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits
" https://github.com/henrik/dotfiles/commit/24ddbd90f75a2383400ef2c912b9ab8a5d5e9fc8
"
" Maps <A-Left/Down/Up/Right> to switch vim splits in the given direction.
" If there are no more windows in that direction, forwards the operation to tmux.
" (Disabled) <A-\> toggles between last active vim splits/tmux panes.
" To have this working with tmux, add this to ~/.tmux.conf
"
" # ------ Smart mixed vim-tmux navigation ------
" # http://robots.thoughtbot.com/post/53022241323/seamlessly-navigate-vim-and-tmux-splits
" # http://sourceforge.net/mailarchive/message.php?msg_id=30519263
" # In Vim, the M(eta) will be interpreted as Alt.
" bind -n M-Left  run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Left)  || tmux select-pane -L"
" bind -n M-Down  run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Down)  || tmux select-pane -D"
" bind -n M-Up    run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Up)    || tmux select-pane -U"
" bind -n M-Right run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Right) || tmux select-pane -R"

let s:tmux_is_last_pane = 0
au WinEnter * let s:tmux_is_last_pane = 0

" Like `wincmd` but also change tmux panes instead of vim windows when needed.
" This version of the script is taken from: https://github.com/mislav/vimfiles/blob/33223b73/plugin/tmux_navigator.vim
" Alternatively, install "christoomey/vim-tmux-navigator"
function s:TmuxWinCmd(direction)
  let nr = winnr()
  let tmux_last_pane = (a:direction == 'p' && s:tmux_is_last_pane)
  if !tmux_last_pane
    " try to switch windows within vim
    exec 'wincmd ' . a:direction
  endif
  " Forward the switch panes command to tmux if:
  " a) we're toggling between the last tmux pane;
  " b) we tried switching windows in vim but it didn't have effect.
  if tmux_last_pane || nr == winnr()
    let cmd = 'tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR')
    call system(cmd)
    let s:tmux_is_last_pane = 1
    echo cmd
  else
    let s:tmux_is_last_pane = 0
  endif
endfunction

" navigate between split windows/tmux panes
nmap <A-Down>   :call <SID>TmuxWinCmd('j')<cr>
nmap <A-Up>     :call <SID>TmuxWinCmd('k')<cr>
nmap <A-Left>   :call <SID>TmuxWinCmd('h')<cr>
nmap <A-Right>  :call <SID>TmuxWinCmd('l')<cr>
" nmap <A-\> :call <SID>TmuxWinCmd('p')<cr>

" ===================
" === Real delete ===
" ===================
" Delete without yanking, to the black hole register.

" <http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal>
" First, fix ALT for gnome terminal
map d  <A-d>
" the ^[ is an Esc char that comes before the 'd'
" In most default configs, ^[d may be typed by pressing first <C-v>, then <M-d>
"
" Second, the actual mapping
" ...current line in normal and insert mode
nnoremap <A-d> "_dd
nnoremap <Leader>d "_dd
" ...selection in visual mode
vnoremap <A-d> "_d
vnoremap <Leader>d "_d
" TODO: does not work
inoremap <A-d> <Esc>"_ddi

" Replace currently selected text with default register without yanking it.
" <http://stackoverflow.com/a/920139>
" Requires that the leader is mapped non-ambiguously, `map , = \` does not work.
vnoremap <leader>p "_dP

" ====================
" === Bubble lines ===
" ====================
" <http://vimcasts.org/episodes/bubbling-text/>
" ...single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" ...multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" ================================
" === Quickfix list navigation ===
" ================================
" It's also useful with plugins like 'ack.vim'
nmap [q :cprevious<cr>
nmap ]q :cnext<cr>

" =========================
" === Working directory ===
" =========================
" expand %% to current directory in the command prompt
" <https://github.com/chrishunt/dot-files/blob/master/.vim/vimrc>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" cd to directory of current buffer, and print it
" <http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" ===============================================
" === Change status line color in insert mode ===
" ===============================================
" <http://fahdshariff.blogspot.co.uk/2012/06/vim-change-statusline-colour-based-on.html>

set laststatus=2
" change highlighting based on mode
" autocmd InsertLeave * highlight StatusLine cterm=bold ctermfg=white ctermbg=brown
autocmd InsertLeave * highlight StatusLine cterm=bold ctermfg=white ctermbg=240
" autocmd InsertEnter * highlight StatusLine cterm=bold ctermfg=white ctermbg=darkblue
autocmd InsertEnter * highlight StatusLine cterm=bold ctermfg=235 ctermbg=2

" ==================================
" === Autowrite, Backup and Undo ===
" ==================================
" http://albertomiorin.com/blog/2012/12/10/autoread-and-autowrite-in-vim/
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost

set nohidden " do not allow switching between buffers with unsaved changes
set nobackup
set noswapfile
set nowritebackup

" Auto-reload buffers when file changed on disk (doesn't work in reality)
set autoread

" =============
" === Mouse ===
" =============
" <http://usevim.com/2012/05/16/mouse/>
set ttyfast          " Send more characters for redraws (faster scrolling)
set mouse=a          " Enable mouse use in all modes
set ttymouse=xterm2  " Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set mousehide        " Hide mouse pointer while typing
set mousemodel=popup

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
nnoremap <C-n> :setlocal number!<cr> " Toggle line numbers
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
nnoremap <leader>v V`]               " <leader>v selects the just pasted text
set virtualedit=block                " allow placing the cursor after the last char
set colorcolumn=81,101               " display vertical rulers for line length
                                     " http://whiletruecode.com/post/adding-a-vertical-ruler-to-vim

" ===========================
" === Trailing whitespace ===
" ===========================
" <http://stackoverflow.com/questions/9121550/vim-highlight-trailing-whitespace-and-spaces-before-and-after-tabs>
" <http://vim.wikia.com/wiki/Highlight_unwanted_spaces>
" set listchars=tab:»·,trail:·,extends:>,precedes:<
" set list

" http://stackoverflow.com/a/1618401/417375
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd FileType c            autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType cpp          autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType java         autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType php          autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType ruby         autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType python       autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType javascript   autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType html         autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType text         autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType markdown     autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType sql          autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType go           autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType sh           autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType coffee       autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType vim          autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType eruby        autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType scss         autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" =============================
" === Last position in file ===
" =============================
" (destroy all software trick)
" Go to the last position from the latest editing
" See :help last-position-jump
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "normal! g`\"" |
  \ endif

" ==========================
" === Search and Replace ===
" ==========================

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
nnoremap <space> :nohlsearch<cr>
" ignore some directories
set wildignore+=*/tmp/*,*.pyc

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
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" ========================================
" === External commands without prompt ===
" ========================================
" <http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts>
" Example
" :Silent tmux send-keys -t 1.2 "bundle exec rspec spec/my_spec.rb" C-m
" => run the tests in the second pane of the first tmux window, enter
" Note that the actual command must be quoted.
command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

" =======================
" === Misc keybinding ===
" =======================

" This was removed from vim-sensible.
" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

" =============
" === CtrlP ===
" =============

let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|bundle)$'

" ===========
" === Ack ===
" ===========
" launch ack without argument with leader+a
nnoremap <leader>a :Ack!<space>

" ================
" === NERDTree ===
" ================
map <leader>n :NERDTreeToggle<cr>
" Highlight the current buffer
map <leader>f :NERDTreeFind<cr>
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
map <leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" Prompt for a command to run
map <leader>rp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <leader>rr :VimuxRunLastCommand<CR>
" Inspect runner pane
map <leader>ri :VimuxInspectRunner<CR>
" Close all other tmux panes in current window
map <leader>rx :VimuxClosePanes<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <leader>rq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <leader>rs :VimuxInterruptRunner<CR>

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
