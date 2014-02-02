" =====================
" === Reuse buffers ===
" =====================
"
" If a buffer is already open in another window, jump to it instead of opening a new window.
set switchbuf=useopen

" ===========================================================
" === Close the current buffer without closing the window ===
" ===========================================================
"
" <http://stackoverflow.com/a/8585343/417375> (terrific solution)
" First, fix ALT key (for gnome-terminal).
map q  <A-q>
" Second, the actual mapping
" ...current line in normal and insert mode
nnoremap <A-q> :bp<bar>sp<bar>bn<bar>bd<CR>
" Alternative keybindings for people with different terminals.
nnoremap <C-q> :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" There is an actual plugin for this, but seems overkill:
" <http://www.vim.org/scripts/script.php?script_id=1147>

" ========================
" === Copy buffer path ===
" ========================
"
" Copy the current buffer full path to the system clipboard with `cp`
" http://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
if has('unnamedplus')
  " ...full path
  nnoremap cpp :let @+ = expand("%:p")<CR>
  " ...relative path
  nnoremap cp :let @+ = expand("%")<CR>
else
  " ...full path
  nnoremap cpp :let @* = expand("%:p")<CR>
  " ...relative path
  nnoremap cp :let @* = expand("%")<CR>
endif

" =========================
" === Switch buffers... ===
" =========================

function NextBuf ()
  if exists(':MBEbn')
    :MBEbn
  else
    :bn
  endif
endfunction

function PrevBuf ()
  if exists(':MBEbp')
    :MBEbp
  else
    :bp
  endif
endfunction

" ...toggle between current and previous
nnoremap <Leader><space> :b#<CR>
" ...next
nnoremap <C-Pagedown> :call NextBuf()<CR>
inoremap <C-Pagedown> :call NextBuf()<CR>
vnoremap <C-Pagedown> :call NextBuf()<CR>
" ...previous
nnoremap <C-Pageup>   :call PrevBuf()<CR>
inoremap <C-Pageup>   :call PrevBuf()<CR>
vnoremap <C-Pageup>   :call PrevBuf()<CR>

" ...without Ctrl key, for mac users
nnoremap <Leader>] :NextBuf()<CR>
inoremap <Leader>] :NextBuf()<CR>
vnoremap <Leader>] :NextBuf()<CR>
nnoremap <Leader>[ :PrevBuf()<CR>
inoremap <Leader>[ :PrevBuf()<CR>
vnoremap <Leader>[ :PrevBuf()<CR>

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
  " close any buffer that's loaded and not visible and not special
  for b in range(1, bufnr('$'))
    " add buflisted() to avoid closing special buffers
    if bufloaded(b) && !has_key(visible, b) && buflisted(b)
      exe 'bd ' . b
    endif
  endfor
endfun

nnoremap bdh :call CloseHiddenBuffers()<CR>

function! CloseAllNormalBuffers()
  " close any buffer that's loaded and not special
  for b in range(1, bufnr('$'))
    " add buflisted() to avoid closing special buffers
    if bufloaded(b) && buflisted(b)
      exe 'bd ' . b
    endif
  endfor
endfun

nnoremap bda :call CloseAllNormalBuffers()<CR>

" ===================
" === Buffergator ===
" ===================
let g:buffergator_viewport_split_policy='R'
let g:buffergator_suppress_keymaps=1
noremap <Leader>b :BuffergatorToggle<CR>

" =======================
" === MiniBufExplorer ===
" =======================
" Put new window above current or on the left for vertical split
let g:miniBufExplBRSplit = 0
let g:miniBufExplUseSingleClick = 1
" Avoid auto-opening MiniBufExplorer for people who don't use it.
let g:miniBufExplAutoStart = 0
nnoremap <Leader>t :MBEFocus<CR>
vnoremap <Leader>t :MBEFocus<CR>
nnoremap <Leader>m :MBEToggle<CR>
vnoremap <Leader>m :MBEToggle<CR>
