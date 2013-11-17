"  Change status line color in insert mode
" ===============================================
"
" <http://fahdshariff.blogspot.co.uk/2012/06/vim-change-statusline-colour-based-on.html>

set laststatus=2
" change highlighting based on mode
" autocmd InsertLeave * highlight StatusLine cterm=bold ctermfg=white ctermbg=brown
autocmd InsertLeave * highlight StatusLine cterm=bold ctermfg=white ctermbg=240
" autocmd InsertEnter * highlight StatusLine cterm=bold ctermfg=white ctermbg=darkblue
autocmd InsertEnter * highlight StatusLine cterm=bold ctermfg=235 ctermbg=2
