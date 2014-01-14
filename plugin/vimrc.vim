" Autoreload ~/.vimrc when edited
" -------------------------------
"
" <https://github.com/bryankennedy/vimrc/blob/master/vimrc>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Per project vimrc
" -----------------
"
" <http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/>
set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
