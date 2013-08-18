" Buffers

" If a buffer is already open in another window, jump to it instead of opening a new window.
set switchbuf=useopen

" Different keybindings for people with different terminals.
" 'close the current buffer without closing the window' (terrific solution)
" <http://stackoverflow.com/a/8585343/417375>
nnoremap <C-q> :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" First, fix ALT key (for gnome-terminal).
map q  <A-q>
" Second, the actual mapping
" ...current line in normal and insert mode
nnoremap <A-q> :bp<bar>sp<bar>bn<bar>bd<CR>

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

" ...with Alt key instead...
nnoremap <A-Pagedown> :bn<CR>
inoremap <A-Pagedown> :bn<CR>
vnoremap <A-Pagedown> :bn<CR>
nnoremap <A-Pageup>   :bp<CR>
inoremap <A-Pageup>   :bp<CR>
vnoremap <A-Pageup>   :bp<CR>
