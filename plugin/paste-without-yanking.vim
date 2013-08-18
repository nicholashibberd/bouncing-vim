" Replace currently selected text with default register without yanking it.
" <http://stackoverflow.com/a/920139>
" Requires that the leader is mapped non-ambiguously, `map , = \` does not work.
vnoremap <Leader>p "_dP
