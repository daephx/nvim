" auto-install vim-plug
let s:script_path = $MYRUNTIME . '/autoload/plug.vim'
if empty(glob(s:script_path))
  silent exec '!curl -fLo ' . s:script_path . ' --create-dirs '
    \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug settings
let g:plug_window = 'botright 20new' " Control split window

call plug#begin($MYRUNTIME . '/autoload/plugged')

  " ======================================
  " * Place your plugin definitions here *
  " ======================================

  " Color Schemes
  Plug 'tomasiser/vim-code-dark'
  " Plug 'navarasu/onedark.nvim'
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

  " Dashboard
  Plug 'glepnir/dashboard-nvim' " custom dashboard/splash screen

  " Icons
  Plug 'kyazdani42/nvim-web-devicons'

  " Statusline
  " Plug 'vim-airline/vim-airline' " Airline - better statusline
  " Plug 'vim-airline/vim-airline-themes' " Color themes for airline
  Plug 'shadmansaleh/lualine.nvim' " statusline written in pure lua
  " Plug 'kdheepak/tabline.nvim' " A buffer and tab tabline for neovim
  " Plug 'akinsho/bufferline.nvim'
  Plug 'romgrk/barbar.nvim' " The neovim tabline plugin

  " Utilities
  Plug 'kassio/neoterm' " Improved terminal support
  Plug 'jiangmiao/auto-pairs' " pair brackets, parens and quotes
  Plug 'lukas-reineke/indent-blankline.nvim' " Indent guides for Neovim
  " Plug 'thaerkh/vim-indentguides' " Simple indentation guides
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " load extensions like VSCode
  Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' } " Recommend updating the parsers on update
  Plug 'romainl/vim-cool' " makes hlsearch more useful
  Plug 'sheerun/vim-polyglot' " Better Syntax Support
  Plug 'tpope/vim-fugitive' " A Git wrapper so awesome, it should be illegal
  Plug 'nvim-lua/plenary.nvim' | Plug 'lewis6991/gitsigns.nvim'
  " Plug 'nvim-lua/plenary.nvim' | Plug 'TimUntersberger/neogit' " magit for neovim
  Plug 'sindrets/diffview.nvim' " Single tabpage interface for easily cycling through diffs
  " Plug 'kyazdani42/nvim-tree.lua' " A file explorer tree for neovim written in lua
  " Plug 'tpope/vim-surround' " quoting/parenthesizing made simple
  Plug 'ojroques/nvim-bufdel' " Neovim improve buffer deletion
  " Plug 'preservim/nerdtree' " File system explorer for the Vim editor
  Plug 'p00f/nvim-ts-rainbow' " Rainbow parentheses for neovim using tree-sitter
  Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown' " Markdown support, tabular MUST load first!
  " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown Live Preview
  " Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " Markdown Live Preview - Requires NodeJS + Yarn
  Plug 'junegunn/goyo.vim' | Plug 'junegunn/limelight.vim' " Distraction free writting, ZenMode
  Plug 'liuchengxu/vim-which-key' " Shows keybindings in popup
  " Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " Shows keybindings in popup - lazy load
  Plug 'vimwiki/vimwiki' " Personal Wiki for Vim
  " Plug 'wfxr/minimap.vim' " minimap / scrollbar written in Rust -- requires deps
  Plug 'preservim/nerdcommenter' " intensely nerdy commenting powers
  Plug 'tweekmonster/startuptime.vim' " Breakdown Vim's --startuptime output
  Plug 'chrisbra/Colorizer' " color hex codes and color names

  " fzf - A command-line fuzzy finder!
  " Makes sure that you have the latest fzf binary
  " Uncomment the first plugin to install locally to neo/vim
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " - Optional
  Plug 'junegunn/fzf.vim' " basic wrapper function for Vim

  " ======================================
  " *       END OF PLUGIN SECTION       *
  " ======================================

call plug#end()
