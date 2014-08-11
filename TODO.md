To do

* fix minibufexplorer colors for solarized light
* escape from buffergator
* consider auto-correction
* add open in split to git grep
* merge `clone_to_bundle_with_home` into install_plugin_with_pathogen
* add scripts for gnome-terminal profiles
* reorganize plugins basic + by subject + get-all option
* more statusline options: <http://got-ravings.blogspot.co.uk/2008/08/vim-pr0n-making-statuslines-that-own.html>
* put the prefix for the temporary install in a variable (vim-plugin-list.sh)
* add notes about setting the terminal app to solarized
* http://tonkersten.com/2011/07/104-switching-to-tmux/
* add current word search to the grep helpers
* Add Q&A section to the readme:
  - how is bouncing-vim different from, say, janus?
  - why is it important to use pathogen instead of Vundle?
* for plugins that end in ".vim" also check the presence of the folder without ".vim"
* toggling lines C-n conflicts with multi-edit plugin
* fix or remove leader not working in insert mode
* IN PROGRESS: fix ALT modifier not working at all on Mac terminals
* toggle between `{}` and `do`-`end`
* source bashrc after updating it <http://stackoverflow.com/questions/16011245/source-files-in-a-bash-script/16011496#16011496>
* add shortcut to remove extra blank lines in the middle of the buffer
* investigate if smooth scrolling is viable/popular...
  - <http://stackoverflow.com/questions/4064651/what-is-the-best-way-to-do-smooth-scrolling-in-vim/12201974#12201974>
  - <https://github.com/Kazark/vim-SimpleSmoothScroll>
  - <https://github.com/terryma/vim-smooth-scroll>
  - <https://github.com/yonchu/accelerated-smooth-scroll>
  - <http://vim.wikia.com/wiki/Page_up/down_and_keep_cursor_position>
* fix molokai theme making difficult doing spell checking because of the current line highlight
* consider the ruby block text-object plugin
* <http://stackoverflow.com/a/1269631/417375>
* Gary Bernhardt rspec tests execution
* either remove or fix autoreload <http://stackoverflow.com/a/10962191>
* re-hardwrap paragraphs of text: nnoremap `<leader>q gqip`
* re-enable vim directives in the files
* select inside and around pipe chars; see also
  - <http://vim.wikia.com/wiki/Creating_new_text_objects>
  - <http://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/>
  the problem is that pipe is a command to "go to column..."
* keybindings to toggle the following options, when performance is an issue
  * :set nocursorline/:NoMatchParen <=> :set cursorline/:DoMatchParen
  * let loaded_matchparen = 1, to avoid loading the parantheses matching built-in plugin
* keybindings for activating/deactivating the automatic line wrapping (reflow)
* join lines in insert mode (not sure it's a good idea)
* trick to create the required directories if needed, directly from the vimrc
* map `<End>` to toggle to the last non-blank char in the line

Other interesting colorschemes
------------------------------

* `wget https://raw.github.com/garybernhardt/dotfiles/master/.vim/colors/grb256.vim -P ~/.vim/colors/`
* <https://github.com/tpope/vim-vividchalk>
* <https://github.com/Lokaltog/vim-distinguished>
* <https://github.com/noahfrederick/Hemisu>
* <https://github.com/morhetz/gruvbox>
* <https://github.com/nanotech/jellybeans.vim>
* <https://github.com/h3rald/stash/blob/master/.vim/colors/herald.vim>

Other interesting plugins
-----------------------

* <https://github.com/rhysd/vim-operator-surround>
* <http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/>
* <http://items.sjbach.com/319>
* <http://net.tutsplus.com/articles/general/top-10-pitfalls-when-switching-to-vim/>
* <http://sourceforge.net/projects/vim-taglist/files/latest/download?source=files>
* <http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines>
* <https://github.com/DawidJanczak/.vim/blob/master/.vimrc>
* <https://github.com/bryankennedy/vimrc/blob/master/vimrc>
* <https://github.com/christoomey/vim-tmux-navigator>
* <https://github.com/henrik/dotfiles>
* <https://github.com/jeffkreeftmeijer/vim-numbertoggle>
* <https://github.com/jistr/vim-nerdtree-tabs>
* <https://github.com/junegunn/vimfiles/blob/master/.vimrc>
* <https://github.com/michaeljsmith/vim-indent-object>
* <https://github.com/mislav/vimfiles>
* <https://github.com/nelstrom/vim-textobj-rubyblock>
* <https://github.com/plasticboy/vim-markdown>
* <https://github.com/prognostikos/dotfiles/blob/master/vim/vimrc.symlink> (from Ruby Rogues Parley)
* <https://github.com/r00k/dotfiles/blob/master/vimrc> (Ben Orenstein)
* <https://github.com/suan/vim-instant-markdown>
* <https://github.com/terryma/vim-expand-region>
* <https://github.com/terryma/vim-multiple-cursors>
* <https://github.com/tomtom/tcomment_vim>
* ssh://hg@bitbucket.org/ns9tks/vim-fuzzyfinder
