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
