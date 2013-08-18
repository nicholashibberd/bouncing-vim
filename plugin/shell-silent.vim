" ========================================
" === External commands without prompt ===
" ========================================
" <http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts>
" Example
" :Silent tmux send-keys -t 1.2 "bundle exec rspec spec/my_spec.rb" C-m
" => run the tests in the second pane of the first tmux window, enter
" Notes
" - when running a tmux command, the actual command must be quoted;
" - bash aliases cannot be used; see snippets for more on this;
command! -nargs=1 Silent
      \ | execute ':silent !'.<q-args>
      \ | execute ':redraw!'
