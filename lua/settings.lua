--    _____      __  __  _
--   / ___/___  / /_/ /_(_)___  ____ ______
--   \__ \/ _ \/ __/ __/ / __ \/ __ `/ ___/
--  ___/ /  __/ /_/ /_/ / / / / /_/ (__  )
-- /____/\___/\__/\__/_/_/ /_/\__, /____/
-- ==========================/____/========
-- Module: settings
-- Description: settings / options for Neovim

local fn = vim.fn
local opt = vim.opt

--- Settings ---

-- General settings for Vim/Neovim

-- Set reusable values
local encode = 'utf-8' -- Default File encoding
local indent = 2 -- Default indentation
local linelimit = 102 -- Default Limit for line length

-- Apply Settings
opt.exrc = true -- Source init file from project
opt.autoread = true -- Load changes made outside of Vim
opt.autochdir = false -- Disable auto cd to open file
opt.smartindent = false -- Insert indents automatically
opt.autoindent = false -- Auto apply indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Round indent to shift width
opt.tabstop = indent -- Number of spaces for tab count
opt.softtabstop = indent
opt.shiftwidth = indent -- Size of an indent
opt.encoding = encode -- Explicitly set file encoding
opt.fileencoding = encode
opt.textwidth = linelimit -- Limit length of characters in a line
opt.linebreak = true -- Split on line break
opt.colorcolumn = '-1' -- Visually display character line limit
opt.background = 'dark'
opt.clipboard = 'unnamed,unnamedplus' -- Use system clipboard
opt.cmdheight = 1 -- Command line character height
opt.conceallevel = 0
opt.foldmethod = 'indent' -- Fold by method (indent & syntax are both good
opt.foldlevelstart = 9 -- We want all fold to be expand at start
opt.foldnestmax = 9 -- Max fold nest levels
opt.cindent = true
opt.wrap = false -- Wrap text when line is too long
opt.hidden = true -- Hide modified buffers instead of unloading them
opt.cursorline = true -- Highlight the text line of the cursor
opt.cursorlineopt = 'number' -- settings for how 'cursorline' is displayed.
opt.incsearch = true -- Enable incremental search
opt.hlsearch = true -- Highlight search
opt.spell = true -- Control vim Spell checking
opt.laststatus = 2 -- Always show statusline
opt.lazyredraw = true -- Execute macros faster
opt.mouse = 'a' -- Enable mouse support
opt.showmode = false -- No EOL message
opt.pumblend = 24 -- Pop-up menu transparency
opt.pumheight = 12 -- Pop-up menu height
opt.pumwidth = 16 -- Pop-up menu thickness
opt.ruler = true -- Always Show cursor position
opt.scrolloff = 8 -- Keep cursor closer to center
opt.showtabline = 2 -- Always show tabline
opt.sidescrolloff = 8 -- Columns of context
opt.sidescroll = 1 -- Smoother horizontal scrolling
opt.signcolumn = 'yes:1' -- Sign gutter options: yes|no : int = size
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Don't ignore case with capitals
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.timeout = true -- time limit for key sequences
opt.timeoutlen = 500 -- Wait for a mapped sequence
opt.ttimeoutlen = 0 -- Instant timeout for terminal buffer
opt.updatetime = 750 -- Time in milliseconds before update
opt.errorbells = false -- Produce noise on error
opt.number = true -- Print line number
opt.relativenumber = true -- Print relative line numbers
opt.swapfile = false -- Disable swap files
opt.backup = false -- Make a backup before overwriting a file
opt.writebackup = false -- backup before overwriting a file
opt.undofile = true -- Persistent undo
opt.undolevels = 1000 -- Maximum number of undoable changes
opt.undoreload = 10000 -- Save the whole buffer for undo
opt.wildmenu = true -- Command-line completion
opt.wildignorecase = true -- Case insensitive command-line completion

opt.formatoptions = 'tqnj' -- describes how auto-format is handled
opt.completeopt = 'menuone,noinsert,noselect' -- Insert mode completion

-- Set what should be included in session files
opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

opt.diffopt:append({ 'vertical' }) -- Start diff mode in vertical split
opt.guifont:append('CaskaydiaCove\\ Nerd\\ Font:h16') -- Preferred fonts
opt.shortmess:append('cfI') -- Avoid 'hit-enter' prompts
opt.whichwrap:append('<,>,[,],h,l')
opt.wildmode:append('full:lastused') -- Command-line completion mode
opt.wildignore:append({ -- Path patterns wild menu should ignore
  '**/.git/*', -- Git Version control
  '**/android/*',
  '**/build/*', -- Common build directory
  '**/coverage/*',
  '**/ios/*',
  '**/node_modules/*', -- Node module environment
  '*.pyc', -- Python cached
  '*_build/*',
})

-- Virtual Characters ---

opt.list = true
opt.listchars = {
  -- eol = '↴',
  space = ' ',
  tab = '  ',
  extends = '»',
  multispace = '·',
  precedes = '«',
  trail = '·',
}

--- Windows ---

-- These settings apply only to nt/windows

if fn.has('win32') == 1 then
  vim.cmd([[
  " Set default shell to powershell
  let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
  set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
  set shellredir=\|\ Out-File\ -Encoding\ UTF8
  set shellquote=\"
  set shellxquote=
]])
end
