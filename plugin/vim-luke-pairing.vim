" .vimrc originally based on https://github.com/DawidJanczak/.vim/blob/master/.vimrc

" TODO: home key -> first non-blank character in the line

" Map leader key to the customary comma without overriding it.
nmap , = \
" Remap leader overriging the existing one
" let mapleader=','

" =========================
" === Per project vimrc ===
" =========================
" <http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/>

set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

" ============================
" === Fix keys inside tmux ===
" ============================

" Preconditions
" - DO NOT set the terminal type in the .tmux.conf;
"   in practice: REMOVE THIS from .tmux.conf => set -g default-terminal "screen-256color"
"
" - INSTEAD set the TERM to 'screen-256color' in the .bashrc:
"
"       if [[ -n "$TMUX" ]]; then
"         export TERM=screen-256color
"       else
"         export TERM=xterm-256color
"       fi

map OD <Left>
map OC <Right>
map [D <C-Left>
map [C <C-Right>
map OA <Up>
map OB <Down>
map [A <C-Up>
map [B <C-Down>

" for tmux
map [6;5~ <C-Pagedown>
map [5;5~ <C-PageUp>

map [1;2C <S-Right>
map [1;2D <S-Left>
map [1;2A <S-Up>
map [1;2B <S-Down>

" <http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ>
" => * How do I make Ctrl-PgUp and Ctrl-PgDn work in vim?
" if &term == "screen"
"   set t_kN=^[[6;*~
"   set t_kN=[5~
"   set t_kP=^[[5;*~
" endif

" <http://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux/402084#402084>
" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" ============
" === Tabs ===
" ============
" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers/3476411#3476411
" tab sball
" set switchbuf=usetab,split
" open every buffer in its own tab
" au BufAdd,BufNewFile,BufRead * nested tab sball
" autocmd BufAdd,BufNewFile * nested tab sball

" Tab navigation like in Firefox
" Notice tha sbnext, sbprevious would reopen closed tabs instead.
" Used for the buffers instead.
" nnoremap <C-Pageup>   :tabprevious<cr>
" nnoremap <C-Pagedown> :tabnext<cr>
" inoremap <C-Pageup>   :tabprevious<cr>
" inoremap <C-Pagedown> :tabnext<cr>

" <http://stackoverflow.com/questions/2468939/how-to-let-tab-display-only-file-name-rather-than-the-full-path-in-vim>
" set guitablabel=\[%N\]\ %t\ %M

" ===========================================================
" === NOTE: Support for CTRL-S and CTRL-Q in the terminal ===
" ===========================================================
" Normally CTRL-S and CTRL-Q suspend and wake up the terminal output in
" terminal emulators (respectively freezing and unfreezing).
" Put this function in the .bashrc to allow instead passing the key combo
" through to vim.
" TODO it's probably better to use something different from `s` and `q` instead.
"
" vim() {
"   local STTYOPTS="$(stty --save)"
"   stty stop '' -ixoff # pass CTRL-S
"   stty start '' -ixon # pass CTRL-Q
"   command vim "$@"
"   stty "$STTYOPTS"
" }

" ============
" === Save ===
" ============
" <http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files>
" Save, but only if the buffer is modified.
" Disabled in insert mode, actually not necessary and just confusing.
" inoremap <C-s> <esc>:update<cr>a
" nnoremap <C-s> :update<cr>
" http://vimdoc.sourceforge.net/htmldoc/usr_40.html#40.2
command W w
command Wa wa
command WA wa
command Q q
command Qa quitall
command QA quitall

" ===============
" === Buffers ===
" ===============

" If a buffer is already open in another window, jump to it instead of
" opening a new window.
set switchbuf=useopen
" 'close the current buffer without closing the window' (terrific solution)
" <http://stackoverflow.com/a/8585343/417375>
nnoremap <C-q> :bp<bar>sp<bar>bn<bar>bd<cr>

" Switch buffers...
" ...between current and previous
nnoremap <leader><space> :b#<cr>
" ...next
" nnoremap <C-j> :bn<cr>
" ...previous
" nnoremap <C-k> :bp<cr>

nnoremap <C-Pageup>   :bp<cr>
nnoremap <C-Pagedown> :bn<cr>
inoremap <C-Pageup>   :bp<cr>
inoremap <C-Pagedown> :bn<cr>
" =================
" === Clipboard ===
" =================
" <http://devinvenable.blogspot.co.uk/2009/12/save-with-ctrl-s-using-vim-and.html>
" <http://vim.wikia.com/wiki/Accessing_the_system_clipboard>
" Requires that Vim has been compiled with clipboard and X11 support.
" On Linux => choose the variant vim-gnome
" set clipboard=unnamedplus

" ctrl-v conflicts with visual block :/
" vnoremap <C-c> "+y
vnoremap <Leader>c "+y
" nnoremap <C-e> "+gP
nnoremap <Leader>o "+gP
" inoremap <C-e> <Esc>"+gPi

" ==================================
" === Move between split windows ===
" ==================================
" <http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" ===================
" === Real delete ===
" ===================
" Delete without yanking (black hole register)...
" ...current line in normal and insert mode
nnoremap <C-f> "_dd
" nnoremap <leader>d "_dd
inoremap <C-f> <Esc>"_ddi
" ...selection in visual mode
vnoremap <C-f> "_d
" vnoremap <leader>d "_d

" Replace currently selected text with default register without yanking it
" <http://stackoverflow.com/a/920139>
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
" This probably won't work in the terminal.
augroup save
  autocmd!
  autocmd FocusLost * wall
  " or suppress warnings for untitled and read-only buffers
  " au FocusLost * silent! wa
augroup END

" allow switching between buffers with unsaved changes
" set hidden
set nohidden
set nobackup
set noswapfile
set nowritebackup

" Write the contents of the file, if it has been modified, on each
" :next, :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!,
" :make, CTRL-] and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I,
" '{A-Z0-9}, or `{A-Z0-9} command takes one to another file.
set autowrite
" Like 'autowrite', but also used for commands :edit, :enew, :quit,
" :qall, :exit, :xit, :recover and closing the Vim window.
" This is necessary for some plugin, I don't remember which one, probably
" vimux.
set autowriteall
" Auto-reload buffers when file changed on disk (doesn't work in reality)
set autoread

" Save swap and undo files elsewhere
" create the dirs if they don't exist, trick from
" <https://github.com/ahawkins/dotfiles/blob/master/vimrc>
" silent !mkdir ~/.vim/swap > /dev/null 2>&1
" silent !mkdir ~/.vim/undo > /dev/null 2>&1
" set backupdir=~/.vim/swap/
" set undodir=~/.vim/undo/
" set undofile " persistent-undo
" set noundofile

" =============
" === Mouse ===
" =============
" <http://usevim.com/2012/05/16/mouse/>
" Send more characters for redraws (faster scrolling)
set ttyfast
" Enable mouse use in all modes
set mouse=a
" ttymouse is the terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2
" Hide mouse pointer while typing
set mousehide
set mousemodel=popup

" ===================
" === Tabulations ===
" ===================
" Tabs mapped to 2 space characters
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" ====================
" === Code folding ===
" ====================
" http://smartic.us/2009/04/06/code-folding-in-vim/
" fold based on syntax
" set foldmethod=syntax
" deepest fold is 7 levels
" set foldnestmax=7
" 2 columns is considered the minumum useful value, although 1 can still serve
" set foldcolumn=2
" no folds are closed when opening a file: can be done in two ways
" - option 1
" set nofoldenable
" - option 2
" set foldlevelstart=99
" set foldlevel=1

" <http://learnvimscriptthehardway.stevelosh.com/chapters/38.html>
" function! ToggleFoldAndNumbers()
"   " Toggle line numbers
"   setlocal number!

"   " Toggle fold column
"   if &foldcolumn
"     setlocal foldcolumn=0
"   else
"     setlocal foldcolumn=2
"   endif
" endfunction

" nnoremap <leader>z :call ToggleFoldAndNumbers()<cr>

" ====================
" === View options ===
" ====================

" Disable all bells
set noerrorbells visualbell t_vb=
" Encoding
set encoding=utf-8
" display line numbers
set number
" Toggle line numbers
nnoremap <C-n> :setlocal number!<cr>
" number of lines visible when scrolling
set scrolloff=3
" change position of the new split panes
set splitright
set splitbelow
" ensure newline and the end of file (the default anyway)
set eol
" wrap long lines
" set wrap
set nowrap
set sidescroll=3
set sidescrolloff=3
" remember indent after going to the next line
set autoindent
" show command that is being entered in the lower right
set showcmd
" show current mode (e.g. input, visual)
set showmode
" highlight currently edited line
set cursorline
" show cursor position in lower right
set ruler
" Allow extended backspace behaviour
set backspace=indent,eol,start
" toggle paste with <F3>, to avoid auto-comment when pasting from system clipboard
set pastetoggle=<F3>
" <leader>v selects the just pasted text
nnoremap <leader>v V`]
" allow placing the cursor after the last char
set virtualedit=block
" http://whiletruecode.com/post/adding-a-vertical-ruler-to-vim
" display vertical rulers for line length
set colorcolumn=81,101
" " To set the colors in a terminal version of Vim, add the following to .vimrc:
" " To see the available color names, issue the command :help ctermbg.
" highlight ColorColumn ctermbg=DarkGray

" ===========================
" === Trailing whitespace ===
" ===========================
" <http://stackoverflow.com/questions/9121550/vim-highlight-trailing-whitespace-and-spaces-before-and-after-tabs>
" <http://vim.wikia.com/wiki/Highlight_unwanted_spaces>
set listchars=tab:»·,trail:·,extends:>,precedes:<
set list

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
autocmd FileType coffeescript autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType vim          autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType eruby        autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" ===============================
" === Filetype customizations ===
" ===============================

" http://beerpla.net/2008/04/02/how-to-add-a-vim-file-extension-to-syntax-highlighting/
syntax enable
filetype on
au BufNewFile,BufRead *.txt set filetype=markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Set filetype for specific names: <http://dailyvim.tumblr.com/post/1262764095/additional-ruby-syntax-highlighting>
autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,config.ru,.caprc,.irbrc,irb_tempfile*,.pryrc,Vagrantfile} set filetype=ruby
" It shouldn't be needed with the mustache.vim plugin
" au BufNewFile,BufRead *.mustache set filetype=html

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
" Don't wrap around (don't start from the beginning when reached the end)
" set nowrapscan
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
" highlight matching parentheses
set showmatch
set matchtime=0 " but stay out of the way (do not jump around)
" clear search results
" ...with space
nnoremap <space> :nohlsearch<cr>
" ...or with the return key (destroy all software trick) (but
" this interferes with Ack-vim, can't use enter to go to the result)
" nnoremap <CR> :nohlsearch<CR>
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

" <http://amix.dk/vim/vimrc.html>
" Visual mode pressing * or # searches for the current selection
" vnoremap <silent> * :call VisualSelection('f')<CR>
" vnoremap <silent> # :call VisualSelection('b')<CR>
"
" function! VisualSelection(direction) range
"     let l:saved_reg = @"
"     execute "normal! vgvy"
"
"     let l:pattern = escape(@", '\\/.*$^~[]')
"     let l:pattern = substitute(l:pattern, "\n$", "", "")
"
"     if a:direction == 'b'
"         execute "normal ?" . l:pattern . "^M"
"     elseif a:direction == 'gv'
"         call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
"     elseif a:direction == 'replace'
"         call CmdLine("%s" . '/'. l:pattern . '/')
"     elseif a:direction == 'f'
"         execute "normal /" . l:pattern . "^M"
"     endif
"
"     let @/ = l:pattern
"     let @" = l:saved_reg
" endfunction

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

" =========================
" === Misc key mappings ===
" =========================
" Map :W to :update (save only when the buffer has been modified)
" Bad idea, because it will replace the letter 'W' with the word 'update'
" ANYWHERE in any command...
" cnoremap W update
" Map :Q to 'no op', effectively disabling it
" noremap Q <Nop>

" ===========
" === Ack ===
" ===========
" launch ack without argument with leader+a
nnoremap <leader>a :Ack!<space>
" launch ack on current word with leader+A
nnoremap <leader>A :Ack!<cword>

" ================
" === NERDTree ===
" ================
" From the NERDTree Readme.
" always open NERDTree when opening a file
" autocmd vimenter * NERDTree
" always open NERDTree even when there is no file open
" autocmd vimenter * if !argc() | NERDTree | endif
" close NERDTree if it is the only vim buffer open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" http://superuser.com/questions/184844/hide-certain-files-in-nerdtree
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeMinimalUI=1
map <leader>n :NERDTreeToggle<cr>

" the additional NerdTreeTabs plugin makes NerdTree play better with tabs
" map <leader>n <plug>NERDTreeTabsToggle<cr>
" Highlight the current buffer
map <leader>f :NERDTreeFind<cr>

" Prevent NERDTree from opening a new split-window
" <http://stackoverflow.com/questions/8323666/make-nerdtree-never-open-a-third-window>
" It's nice in theory but it seems to work pretty randomly.
set buftype=

" ===================
" === Buffergator ===
" ===================
let g:buffergator_viewport_split_policy='R'

" =======================
" === MiniBufExplorer ===
" =======================
" Put new window above current or on the left for vertical split
let g:miniBufExplBRSplit = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplBuffersNeeded = 1 " open immediately, don't wait for a second buffer

" prevent MiniBufExplorer from overriding our colours
" let g:did_minibufexplorer_syntax_inits = 1

" Custom colors for buffers...
" highlight MBENormal ctermfg=15
" highlight MBEChanged ctermfg=199
" highlight MBEVisibleNormal ctermfg=14
" highlight MBEVisibleChanged ctermfg=178
" highlight MBEVisibleActiveNormal ctermfg=40
" highlight MBEVisibleActiveChanged ctermfg=199

" " Custom colors for buffers...
" " ...NOT CHANGED and NOT VISIBLE
" autocmd ColorScheme * highlight MBENormal ctermfg=15
" " ...CHANGED and NOT VISIBLE
" autocmd ColorScheme * highlight MBEChanged ctermfg=199
" " ...NOT CHANGED and VISIBLE
" autocmd ColorScheme * highlight MBEVisibleNormal ctermfg=14
" " ...CHANGED and VISIBLE
" autocmd ColorScheme * highlight MBEVisibleChanged ctermfg=178
" " ...NOT CHANGED, VISIBLE and ACTIVE
" autocmd ColorScheme * highlight MBEVisibleActiveNormal ctermfg=40
" " ...CHANGED, VISIBLE and ACTIVE
" autocmd ColorScheme * highlight MBEVisibleActiveChanged ctermfg=199

" ===================
" === Go language ===
" ===================
" From the readme at ~/bin/go/misc/vim/readme.txt
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" ==========================
" === vimux - vim + tmux ===
" ==========================
" Requires vim compiled with ruby support.
" It may require autowriteall to avoid error messages.

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
