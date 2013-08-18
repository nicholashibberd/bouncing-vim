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
