" ===================================
" === Grep with external programs ===
" ===================================

" Set a different grep program
" ----------------------------
"
" This is taken from http://robots.thoughtbot.com/faster-grepping-in-vim.
" See also: http://learnvimscriptthehardway.stevelosh.com/chapters/32.html
"
" The motivation to add this was that, although 'ag' was installed on Ubuntu
" from the official repositories, it wasn't detected by ack.vim, and the
" plugin did't work.
" It's been left as it provides useful functionality with very little
" code, especially when no other plugins are available for this purpose.
"
if executable('grep')
  " http://vim.wikia.com/wiki/Find_in_files_within_Vim
  " -s: don't print error messages about missing or non readable files
  " -r: recursive
  " -n: print line numbers
  " -E: use extended regular expressions
  " -I: ignore binary files
  set grepprg=grep\ -srnEI\ --exclude-dir=.git\ .\ -e
endif

if executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor
endif

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" grep 'bang' won't jump to the first result
command -nargs=+ -complete=file -bar G silent! grep! <args>|cwindow|redraw!

nnoremap \\ :G<SPACE>

" Use 'git grep' as grepprg
" -------------------------
"
" The 'fugitive' plugin already provides a much more evoluted and powerful
" solution with the Ggrep command.
" However, this is an interesting minimal option for when even fugitive
" is not available.
" With minor adaptations from:
" - http://stackoverflow.com/questions/2415237/techniques-in-git-grep-and-vim/2415257#2415257
" - http://vim.wikia.com/wiki/Git_grep
" - http://learnvimscriptthehardway.stevelosh.com/chapters/32.html
" Adds support for current word

func GitGrep(args)
  let l:original_grepprg = $grepprg
  set grepprg=git\ grep\ -n\ $*

  " grep bang will not jump to the first result
  if empty(a:args)
    let l:currword = expand('<cword>')
    if strlen(l:currword) == 0
      return
    else
      let l:cmd_string = "grep! -w " . l:currword
    endif
  else
    " escape the same way as ack.vim
    let l:cmd_string = 'grep! ' . escape(a:args, '|#%')
  endif

  silent execute l:cmd_string
  let &grepprg = l:original_grepprg
  copen
  redraw!
endfun

command -nargs=* -complete=file GG call GitGrep(<q-args>)
nnoremap \\\ :GG<SPACE>

" Faster ':vimgrep' with noautocmd
" --------------------------------

" Search current word in files with current extension
nnoremap <Leader>s :noautocmd vimgrep
  \ /<C-r>=(expand("<cword>"))<CR>/gj
  \ **/*.<C-r>=(expand("%:e"))<CR>
  \<C-left><Left>
