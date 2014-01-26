todo
----

* fix molokai theme making difficult doing spell checking because of the current line highlight
* add option to check if one is using pathogen when installing the plugins
* when installing vim, give an option to keep the existing `~/.vim/` directory
* add back download of vim with mercurial as an option (still default to the simple tarball download)
* consider the ruby block text-object plugin
* fix ALT+D real delete on Mac
* add prompt to continue if there's a ~/.vim already
* <http://stackoverflow.com/a/1269631/417375>
* consider not re-entering normal mode after quick-save with ctrl-s
* consider leader+S for quick save
* Remove Ultisnips???
* Remove xmp filter?
* Gary Bernhardt rspec tests execution
* either remove or fix autoreload <http://stackoverflow.com/a/10962191>
* <http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines>
* re-hardwrap paragraphs of text: nnoremap <leader>q gqip
* insert line no insert mode
* ensure that indentation is absolute, not relative to initial position
* use minibufexplorer mappings to swtich buffers if the plugin is available
* reenable vim directives in the files
* select inside and around pipe chars; see also
  - <http://vim.wikia.com/wiki/Creating_new_text_objects>
  - <http://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/>
  the problem is that pipe is a command to "go to column..."
* toggle between {} and do-end
* keybindings to toggle the following options, when performance is an issue
  * :set nocursorline/:NoMatchParen <=> :set cursorline/:DoMatchParen
  * let loaded_matchparen = 1
* keybindings for split panes resising
* keybindings for activating/deactivating the automatic line wrapping (reflow)
* join lines in insert mode (not sure it's a good idea)
* trick to create the required directories if needed, directly from the vimrc
* Add snippets for required tmux and bash conf to the readme

Interesting vimrc files
-----------------------

* <https://github.com/r00k/dotfiles/blob/master/vimrc> (Ben Orenstein)
* <http://items.sjbach.com/319>
* <https://github.com/DawidJanczak/.vim/blob/master/.vimrc>
* <https://github.com/bryankennedy/vimrc/blob/master/vimrc>
* <https://github.com/henrik/dotfiles>
* <https://github.com/mislav/vimfiles>
* <https://github.com/junegunn/vimfiles/blob/master/.vimrc>
* <http://net.tutsplus.com/articles/general/top-10-pitfalls-when-switching-to-vim/>
