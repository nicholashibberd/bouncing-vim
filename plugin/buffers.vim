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

" Close all the buffers
" https://github.com/bryankennedy/vimrc/blob/master/vimrc
nnoremap bda :1,300 bd<CR>

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

" ============================================
" === Close all hidden non-special buffers ===
" ============================================
"
" source http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
" modified to ensure that the buffers to close are normal (listed) buffers
"
" Other similar functions:
" http://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers>
" https://gist.github.com/skanev/1068214>
" http://vim.1045645.n5.nabble.com/close-all-unvisible-buffers-td4262697.html>
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that's loaded and not visible
  for b in range(1, bufnr('$'))
    " add buflisted() to avoid closing special buffers
    if bufloaded(b) && !has_key(visible, b) && buflisted(b)
      exe 'bd ' . b
    endif
  endfor
endfun

nnoremap bda :call CloseHiddenBuffers()<CR>
