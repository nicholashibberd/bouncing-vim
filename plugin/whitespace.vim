" ===========================
" === Trailing whitespace ===
" ===========================
" <http://stackoverflow.com/questions/9121550/vim-highlight-trailing-whitespace-and-spaces-before-and-after-tabs>
" <http://vim.wikia.com/wiki/Highlight_unwanted_spaces>
set listchars=tab:»·,trail:·,extends:>,precedes:<
" set listchars=tab:>-,trail:·,eol:$
" set list
" Whitespace will be hidden by default, but it's possible to toggle it
" http://items.sjbach.com/319
nmap <silent> <leader>w :set nolist!<CR>

" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim/1618401#1618401
" http://stackoverflow.com/questions/7495932/how-can-i-trim-blank-lines-at-the-end-of-file-in-vim/7496112#7496112
" http://vim.wikia.com/wiki/Remove_unwanted_empty_lines
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")

  " 1 - Delete whitespace at the end of the lines
  %s/\s\+$//e

  " 2 - Replace three or more consecutive line endings with two line endings (a
  " single blank line).
  " %s/\n\{3,}/\r\r/e

  " 3 - Remove extra blank lines at the end of file. Use silent to avoid warning
  " for 'pattern not found'.
  "
  " \( ..... Start a match group
  "   $\n ... Match a new line (end-of-line character followed by a carriage return).
  "   \s* ... Allow any amount of whitespace on this new line
  " \) ..... End the match group
  " \+ ..... Allow any number of occurrences of this group (one or more).
  " \%$ ... Match the end of the file
  silent! %s/\($\n\s*\)\+\%$//

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
autocmd FileType Dockerfile   autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType puppet       autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
