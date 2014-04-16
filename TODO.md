To do
-----

* add info to the message for the vimrc: linking is recommended, because it's still possible to use the vimrc.after
* fix underlining style in agnostic colorscheme
* fix <F6> in insert mode
* Add Q&A section to the readme:
  - how is bouncing-vim different from, say, janus?
  - why is it important to use pathogen instead of Vundle?
* create functions to link to the rc files
* use `mv` instead of `rm` to in the install scripts
* for plugins that end in ".vim" also check the presence of the folder without ".vim"
* toggling lines C-n conflicts with multi-edit plugin
* add syntastic: doubtful, some people dislike it because intrusive
* fix or remove leader not working in insert mode
* copy current word or visually selected text in the command line; this is a start <http://stackoverflow.com/a/4879083>
* fix tmux-scripts/3-option-2-tmux-custom-scripts for when there is no "pair" user
* IN PROGRESS: fix ALT modifier not working at all on Mac terminals
* investigate home key not working in some virtual machines
* toggle between `{}` and `do`-`end`
* source bashrc after updating it <http://stackoverflow.com/questions/16011245/source-files-in-a-bash-script/16011496#16011496>
* add shortcut to remove extra blank lines in the middle of the buffer
* add a shortcut to change NERDTree dir to the location of the current buffer
* investigate if smooth scrolling is viable/popular...
  - <http://stackoverflow.com/questions/4064651/what-is-the-best-way-to-do-smooth-scrolling-in-vim/12201974#12201974>
  - <https://github.com/Kazark/vim-SimpleSmoothScroll>
  - <https://github.com/terryma/vim-smooth-scroll>
  - <https://github.com/yonchu/accelerated-smooth-scroll>
  - <http://vim.wikia.com/wiki/Page_up/down_and_keep_cursor_position>
* fix molokai theme making difficult doing spell checking because of the current line highlight
* consider the ruby block text-object plugin
* <http://stackoverflow.com/a/1269631/417375>
* consider leader+S for quick save
* Remove Ultisnips???
* Remove xmp filter?
* Gary Bernhardt rspec tests execution
* either remove or fix autoreload <http://stackoverflow.com/a/10962191>
* re-hardwrap paragraphs of text: nnoremap `<leader>q gqip`
* ensure that indentation is absolute, not relative to initial position (???)
* check if minibufexplorer is available before using it for mappings
* reenable vim directives in the files
* select inside and around pipe chars; see also
  - <http://vim.wikia.com/wiki/Creating_new_text_objects>
  - <http://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/>
  the problem is that pipe is a command to "go to column..."
* keybindings to toggle the following options, when performance is an issue
  * :set nocursorline/:NoMatchParen <=> :set cursorline/:DoMatchParen
  * let loaded_matchparen = 1, to avoid loading the parantheses matching built-in plugin
* keybindings for split panes resising
* keybindings for activating/deactivating the automatic line wrapping (reflow)
* join lines in insert mode (not sure it's a good idea)
* trick to create the required directories if needed, directly from the vimrc
* map `<End>` to toggle to the last non-blank char in the line
