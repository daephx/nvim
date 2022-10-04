--    _____      __  __  _
--   / ___/___  / /_/ /_(_)___  ____ ______
--   \__ \/ _ \/ __/ __/ / __ \/ __ `/ ___/
--  ___/ /  __/ /_/ /_/ / / / / /_/ (__  )
-- /____/\___/\__/\__/_/_/ /_/\__, /____/
-- ==========================/____/========
-- Module: settings
-- Description: settings / options for Neovim

--- Settings ---

-- General settings for Vim/Neovim

-- Set reusable values
local encode = 'utf-8' -- Default File encoding
local indent = 2 -- Default indentation
local linelimit = 102 -- Default Limit for line length

-- Apply Settings
vim.opt.autoread = true -- Load changes made outside of Vim
vim.opt.autochdir = false -- Disable auto cd to open file
vim.opt.smartindent = false -- Insert indents automatically
vim.opt.autoindent = false -- Auto apply indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftround = true -- Round indent to shift width
vim.opt.tabstop = indent -- Number of spaces for tab count
vim.opt.softtabstop = indent
vim.opt.shiftwidth = indent -- Size of an indent
vim.opt.encoding = encode -- Explicitly set file encoding
vim.opt.fileencoding = encode
vim.opt.textwidth = linelimit -- Limit length of characters in a line
vim.opt.linebreak = true -- Split on line break
vim.opt.colorcolumn = '-1' -- Visually display character line limit
vim.opt.background = 'dark'
vim.opt.clipboard = 'unnamed,unnamedplus' -- Use system clipboard
vim.opt.cmdheight = 1 -- Command line character height
vim.opt.conceallevel = 0
vim.opt.foldmethod = 'indent' -- Fold by method (indent & syntax are both good
vim.opt.foldlevelstart = 9 -- We want all fold to be expand at start
vim.opt.foldnestmax = 9 -- Max fold nest levels
vim.opt.cindent = true
vim.opt.wrap = false -- Wrap text when line is too long
vim.opt.hidden = true -- Hide modified buffers instead of unloading them
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.cursorlineopt = 'number' -- settings for how 'cursorline' is displayed.
vim.opt.incsearch = true -- Enable incremental search
vim.opt.hlsearch = true -- Highlight search
vim.opt.spell = true -- Control vim Spell checking
vim.opt.laststatus = 3 -- Apply statusline options
vim.opt.lazyredraw = true -- Execute macros faster
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.showmode = false -- No EOL message
vim.opt.pumblend = 24 -- Pop-up menu transparency
vim.opt.pumheight = 12 -- Pop-up menu height
vim.opt.pumwidth = 16 -- Pop-up menu thickness
vim.opt.ruler = true -- Always Show cursor position
vim.opt.scrolloff = 8 -- Keep cursor closer to center
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.sidescroll = 1 -- Smoother horizontal scrolling
vim.opt.signcolumn = 'yes:2' -- Sign gutter options: yes|no : int = size
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.termguicolors = true -- True color support
vim.opt.timeout = true -- time limit for key sequences
vim.opt.timeoutlen = 500 -- Wait for a mapped sequence
vim.opt.ttimeoutlen = 0 -- Instant timeout for terminal buffer
vim.opt.updatetime = 750 -- Time in milliseconds before update
vim.opt.errorbells = false -- Produce noise on error
vim.opt.number = true -- Print line number
vim.opt.relativenumber = true -- Print relative line numbers
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Make a backup before overwriting a file
vim.opt.writebackup = false -- backup before overwriting a file
vim.opt.undofile = true -- Persistent undo
vim.opt.undolevels = 1000 -- Maximum number of undoable changes
vim.opt.undoreload = 10000 -- Save the whole buffer for undo
vim.opt.wildmenu = true -- Command-line completion
vim.opt.wildignorecase = true -- Case insensitive command-line completion

vim.opt.formatoptions = 'tqnj' -- describes how auto-format is handled
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Insert mode completion

-- Set what should be included in session files
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

vim.opt.diffopt:append({ 'vertical' }) -- Start diff mode in vertical split
vim.opt.guifont:append('CaskaydiaCove\\ Nerd\\ Font:h16') -- Preferred fonts
vim.opt.shortmess:append('cfI') -- Avoid 'hit-enter' prompts
vim.opt.whichwrap:append('<,>,[,],h,l')
vim.opt.wildmode:append('full:lastused') -- Command-line completion mode
vim.opt.wildignore:append({ -- Path patterns wild menu should ignore
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

vim.opt.list = true
vim.opt.listchars = {
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

if vim.fn.has('win32') == 1 then
  vim.cmd([[
  " Set default shell to powershell
  let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
  set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
  set shellredir=\|\ Out-File\ -Encoding\ UTF8
  set shellquote=\"
  set shellxquote=
]])
end
