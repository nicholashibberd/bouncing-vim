" Buffers

" If a buffer is already open in another window, jump to it instead of opening a new window.
set switchbuf=useopen

" 'close the current buffer without closing the window' (terrific solution)
" <http://stackoverflow.com/a/8585343/417375>
" First, fix ALT key (for gnome-terminal).
map q  <A-q>
" Second, the actual mapping
" ...current line in normal and insert mode
nnoremap <A-q> :bp<bar>sp<bar>bn<bar>bd<CR>
" Alternative keybindings for people with different terminals.
nnoremap <C-q> :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Copy the current buffer full path to the system clipboard with `cp`
" http://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
nnoremap cp :let @+ = expand("%:p")<CR>

"""""""""""""""""""
" Switch buffers...
" ...toggle between current and previous
nnoremap <Leader><space> :b#<CR>
" ...next
nnoremap <C-Pagedown> :bn<CR>
inoremap <C-Pagedown> :bn<CR>
vnoremap <C-Pagedown> :bn<CR>
" ...previous
nnoremap <C-Pageup>   :bp<CR>
inoremap <C-Pageup>   :bp<CR>
vnoremap <C-Pageup>   :bp<CR>

" ...without Ctrl key, for mac users
nnoremap <Leader>] :bn<CR>
inoremap <Leader>] :bn<CR>
vnoremap <Leader>] :bn<CR>
nnoremap <Leader>[ :bp<CR>
inoremap <Leader>[ :bp<CR>
vnoremap <Leader>[ :bp<CR>

" ...as if they were tabs, for some Vim users
" nnoremap <S-h> :bp<CR>
" nnoremap <S-l> :bn<CR>
