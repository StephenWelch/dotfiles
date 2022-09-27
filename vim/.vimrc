let mapleader = ","

let g:camelcasemotion_key = '<leader>'
let g:highlightedyank_highlight_duration = "-1"
let g:highlightedyank_highlight_color = "rgba(52, 149, 235, 127)"

" Map jj to Esc since we never type that sequence 
imap jj <Esc>
" nnoremap <C-t> :NERDTree<CR>

" :command Tree NERDTree

call plug#begin()
Plug 'tpope/vim-surround' " Allows manipulation of enclosing characters
Plug 'vim-scripts/ReplaceWithRegister' " Replace text directly from register
Plug 'vim-scripts/argtextobj.vim' " Change and traverse function arguments
Plug 'machakann/vim-highlightedyank' " Highlight yanked text
Plug 'jeffkreeftmeijer/vim-numbertoggle' " Switches line numbering mode to absolute/relative depending on whether editor is in insert/relative mode
Plug 'tpope/vim-fugitive' " Git support
Plug 'vim-airline/vim-airline' " Nice-looking statusline
" Plug 'preservim/nerdtree' " File tree
Plug 'bkad/CamelCaseMotion' " Motions for CamelCase
call plug#end()

set mouse=a
set autoindent " Indents the next opened line as the same as preceding
set smartindent " Enable language-aware auto-indentation
set clipboard+=unnamedplus " Enable copy-pasting in system from register 0 across all platforms
set number " Enable line numbering
set relativenumber " Make line numbers relative to current line. Combined with vim-numbertoggle to automatically switch based on editor mode
set tabstop=4 " Display tabs as 4 spaces
set smarttab " Pressing tab will always align cursor to the next tab column

