" =================================================
" === Move between split windows AND tmux panes ===
" =================================================
"
" Maps <A-Left/Down/Up/Right> to switch vim splits in the given direction.
" If there are no more windows in that direction, forwards the operation to tmux.
" (Disabled) <A-\> toggles between last active vim splits/tmux panes.
" To have this working with tmux, add this to ~/.tmux.conf
"
" The chosen version is taken from:
" - http://sourceforge.net/mailarchive/message.php?msg_id=30519263
"
" Other resources on the subject:
" - http://robots.thoughtbot.com/post/53022241323/seamlessly-navigate-vim-and-tmux-splits
" - https://github.com/christoomey/vim-tmux-navigator
" - https://gist.github.com/mislav/5189704
" - https://gist.github.com/mislav/5189704/revisions
" - http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits
" - https://github.com/henrik/dotfiles/commit/24ddbd90f75a2383400ef2c912b9ab8a5d5e9fc8
"
" -------- ~/.tmux.conf ---------
" M(eta) is the Alt key both in Vim and tmux.
" bind -n M-Left  run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Left)  || tmux select-pane -L"
" bind -n M-Down  run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Down)  || tmux select-pane -D"
" bind -n M-Up    run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Up)    || tmux select-pane -U"
" bind -n M-Right run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys M-Right) || tmux select-pane -R"
" -------- END ~/.tmux.conf ---------

let s:tmux_is_last_pane = 0
au WinEnter * let s:tmux_is_last_pane = 0

" Like `wincmd` but also change tmux panes instead of vim windows when needed.
" This version of the script is taken from: https://github.com/mislav/vimfiles/blob/33223b73/plugin/tmux_navigator.vim
" Alternatively, install "christoomey/vim-tmux-navigator"
function s:TmuxWinCmd(direction)
  let nr = winnr()
  let tmux_last_pane = (a:direction == 'p' && s:tmux_is_last_pane)
  if !tmux_last_pane
    " try to switch windows within vim
    exec 'wincmd ' . a:direction
  endif
  " Forward the switch panes command to tmux if:
  " a) we're toggling between the last tmux pane;
  " b) we tried switching windows in vim but it didn't have effect.
  if tmux_last_pane || nr == winnr()
    let cmd = 'tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR')
    call system(cmd)
    let s:tmux_is_last_pane = 1
    echo cmd
  else
    let s:tmux_is_last_pane = 0
  endif
endfunction

" navigate between split windows/tmux panes
nmap <A-Down>   :call <SID>TmuxWinCmd('j')<CR>
nmap <A-Up>     :call <SID>TmuxWinCmd('k')<CR>
nmap <A-Left>   :call <SID>TmuxWinCmd('h')<CR>
nmap <A-Right>  :call <SID>TmuxWinCmd('l')<CR>
" nmap <A-\> :call <SID>TmuxWinCmd('p')<CR>
