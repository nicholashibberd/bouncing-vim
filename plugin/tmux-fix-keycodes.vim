" =====================================
" === Fix keys when running in tmux ===
" =====================================

" This requires (besides some faith and luck)...
"
" 1 - ...to set the TERM correctly in bashrc
"
" if [[ -n "$TMUX" ]]; then
"   export TERM=screen-256color
" else
"   export TERM=xterm-256color
" fi
"
" 2 - ...to set xterm key forwarding in tmux.conf
" set -g xterm-keys on
"
" <http://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux/402084#402084>
" <http://denihow.com/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux/>
" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
  map [6;5~ <C-Pagedown>
  map [5;5~ <C-PageUp>
  map [6;3~ <A-Pagedown>
  map [5;3~ <A-Pageup>

  exec "set <Home>=\e[1~"

  exec "set <xUp>=\e[1;*A"
  exec "set <xDown>=\e[1;*B"
  exec "set <xRight>=\e[1;*C"
  exec "set <xLeft>=\e[1;*D"
endif

