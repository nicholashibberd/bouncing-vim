" Replace visually selected
"
" http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
" By pressing ctrl + r in the visual mode you will be prompted to enter text
" to replace with. Press enter and then confirm each change.
vnoremap <C-r> "hy:%s/<C-r>h//gc<Left><Left><Left>
