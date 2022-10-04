--    ____        __  _
--   / __ \____  / /_(_)___  ____  _____
--  / / / / __ \/ __/ / __ \/ __ \/ ___/
-- / /_/ / /_/ / /_/ / /_/ / / / (__  )
-- \____/ .___/\__/_/\____/_/ /_/____/
-- ====/_/==============================
-- Neovim general editor options/settings

-- Set reusable values
local encode = 'utf-8' -- File encoding
local indent = 2 -- Indentation size
local linelimit = 102 -- Limit for line length

-- General options
vim.opt.autoread = true -- Load changes made outside of Vim
vim.opt.autochdir = false -- Change working directory to active buffer
vim.opt.smartindent = false -- Insert indents automatically
vim.opt.autoindent = false -- Auto apply indentation
vim.opt.expandtab = true -- Expand tabs characters to spaces
vim.opt.shiftround = true -- Round indent to shift width
vim.opt.tabstop = indent -- Number of spaces for tab count
vim.opt.softtabstop = indent -- Spaces a <Tab> counts during edit operations
vim.opt.shiftwidth = indent -- Number of spaces for indents
vim.opt.encoding = encode -- Explicitly set file encoding
vim.opt.fileencoding = encode -- Set File-content encoding for the current buffer
vim.opt.textwidth = linelimit -- Limit length of characters per line
vim.opt.linebreak = true -- Split on line break
vim.opt.colorcolumn = '+1' -- Visually display character line limit
vim.opt.background = 'dark' -- Adjusts the default color groups for background type
vim.opt.clipboard = 'unnamed,unnamedplus' -- Configure system clipboard support
vim.opt.cmdheight = 1 -- Command line character height
vim.opt.conceallevel = 0 -- Determine how text with the "conceal" syntax is handled
vim.opt.foldmethod = 'indent' -- Fold by method (indent & syntax are both good
vim.opt.foldlevelstart = 9 -- We want all fold to be expand at start
vim.opt.foldnestmax = 9 -- Max fold nest levels
vim.opt.cindent = false -- Indent using C indenting rules
vim.opt.wrap = false -- Wrap text when line is too long
vim.opt.hidden = true -- Hide modified buffers instead of unloading them
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.cursorlineopt = 'number' -- Control how 'cursorline' is displayed
vim.opt.incsearch = true -- Enable incremental search
vim.opt.hlsearch = true -- Enable search highlighting
vim.opt.spell = true -- Control vim Spell checking
vim.opt.laststatus = 3 -- Apply statusline options
vim.opt.lazyredraw = true -- Execute macros faster
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.showmode = false -- Manage whether EOL message is shown
vim.opt.pumblend = 24 -- Pop-up menu transparency
vim.opt.pumheight = 12 -- Pop-up menu height
vim.opt.pumwidth = 16 -- Pop-up menu thickness
vim.opt.ruler = true -- Always show cursor position
vim.opt.scrolloff = 8 -- Keep cursor closer to center vertically
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.sidescrolloff = 8 -- Keep cursor closer to center horizontally
vim.opt.sidescroll = 1 -- Smoother horizontal scrolling
vim.opt.signcolumn = 'yes:2' -- Sign gutter options: yes|no : int = size
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Override search if pattern contains uppercase
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.termguicolors = true -- Enable true color support
vim.opt.timeout = true -- Time limit for key sequences
vim.opt.timeoutlen = 500 -- Timeout for mapped sequence
vim.opt.ttimeoutlen = 0 -- Timeout for key code sequence
vim.opt.updatetime = 750 -- Timeout idle before CursorHold or updating swapfile
vim.opt.belloff = 'all' -- Events error bells will be suppressed
vim.opt.errorbells = false -- Produce audible error feedback
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

-- Describes how auto-format is handled
vim.opt.formatoptions = 'tqnj'
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
  '**/android/*', -- Google Android build
  '**/build/*', -- Generic build artifacts
  '**/coverage/*', -- Test coverage reports
  '**/ios/*', -- Apple iOS build
  '**/node_modules/*', -- Node module environment
  '*.pyc', -- Python byte code
  '*_build/*', -- Private build artifacts
})

-- Virtual Characters ---

vim.opt.list = true
vim.opt.listchars = {
  eol = ' ', -- End of line ↴
  extends = '»', -- Horizontal overflow
  multispace = '·', -- Consecutive whitespace
  precedes = '«', -- Horizontal underflow
  space = ' ', -- Standard Whitespace
  tab = '  ', -- Tab indentation
  trail = '·', -- Trailing whitespace
}

--- Windows ---

-- Options that only apply to nt/windows
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
