To do
-----

* insert line no insert mode
* toggle between `{}` and `do`-`end`
* source bashrc after updating it <http://stackoverflow.com/questions/16011245/source-files-in-a-bash-script/16011496#16011496>
* add shortcut to remove extra blank lines in the middle of the buffer
* investigate home key not working in some virtual machines
* add a shortcut to change NERDTree dir to the location of the current buffer
* investigate if smooth scrolling is viable/popular...
  - <http://stackoverflow.com/questions/4064651/what-is-the-best-way-to-do-smooth-scrolling-in-vim/12201974#12201974>
  - <https://github.com/Kazark/vim-SimpleSmoothScroll>
  - <https://github.com/terryma/vim-smooth-scroll>
  - <https://github.com/yonchu/accelerated-smooth-scroll>
  - <http://vim.wikia.com/wiki/Page_up/down_and_keep_cursor_position>
* fix molokai theme making difficult doing spell checking because of the current line highlight
* add back download of vim with mercurial as an option (still default to the simple tarball download)
* consider the ruby block text-object plugin
* fix ALT+D real delete on Mac
* <http://stackoverflow.com/a/1269631/417375>
* consider not re-entering normal mode after quick-save with ctrl-s
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
  * let loaded_matchparen = 1
* keybindings for split panes resising
* keybindings for activating/deactivating the automatic line wrapping (reflow)
* join lines in insert mode (not sure it's a good idea)
* trick to create the required directories if needed, directly from the vimrc

Interesting vimrc files
-----------------------

* <http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines>
* <https://github.com/prognostikos/dotfiles/blob/master/vim/vimrc.symlink> (from Ruby Rogues Parley)
* <https://github.com/r00k/dotfiles/blob/master/vimrc> (Ben Orenstein)
* <http://items.sjbach.com/319>
* <https://github.com/DawidJanczak/.vim/blob/master/.vimrc>
* <https://github.com/bryankennedy/vimrc/blob/master/vimrc>
* <https://github.com/henrik/dotfiles>
* <https://github.com/mislav/vimfiles>
* <https://github.com/junegunn/vimfiles/blob/master/.vimrc>
* <http://net.tutsplus.com/articles/general/top-10-pitfalls-when-switching-to-vim/>
