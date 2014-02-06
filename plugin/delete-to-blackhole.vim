" ===================
" === Real delete ===
" ===================
" Delete without yanking, to the black hole register.

" <http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal>
" First, fix ALT for gnome terminal
map d  <M-d>
map ∂ <M-d>
" the ^[ is an Esc char that comes before the 'd'
" In most default configs, ^[d may be typed by pressing first <C-v>, then <M-d>
"
" Second, the actual mapping
" ...current line in normal and insert mode
nnoremap <M-d> "_dd
nnoremap <Leader>d "_dd
" ...selection in visual mode
vnoremap <M-d> "_d
vnoremap <Leader>d "_d
