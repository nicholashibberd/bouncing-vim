" =======================================
" === Indent without losing selection ===
" =======================================

" Vim tip 224 http://vim.wikia.com/wiki/Shifting_blocks_visually
vnoremap > >gv
vnoremap < <gv

" =================================
" === Reselect last edited text ===
" =================================

" gp selects the just changed or pasted text
" <http://vim.wikia.com/wiki/Selecting_your_pasted_text>
" (it uses `gp` in the wiki, but conflicts with standard gp, which is paste
" going to the end of the pasted text)
nnoremap <expr> <Leader>v '`[' . strpart(getregtype(), 0, 1) . '`]'

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
"
" http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
" By pressing ctrl + r in the visual mode you will be prompted to enter text
" to replace with. Press enter and then confirm each change.
" vnoremap <C-r> "hy:%s/<C-r>h//gc<Left><Left><Left>

" Get the current visual block for search and replaces
" https://github.com/bryankennedy/vimrc/blob/master/vimrc

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" This function passed the visual block through a string escape function
" Based on http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vnoremap <C-r>  <Esc>:%s/<c-r>=GetVisual()<cr>//c<Left><Left>
