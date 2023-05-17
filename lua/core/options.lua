--    ____        __  _
--   / __ \____  / /_(_)___  ____  _____
--  / / / / __ \/ __/ / __ \/ __ \/ ___/
-- / /_/ / /_/ / /_/ / /_/ / / / (__  )
-- \____/ .___/\__/_/\____/_/ /_/____/
-- ====/_/==============================
-- Neovim general editor options/settings

vim.g.mapleader = " " -- Default leader for keymaps
vim.g.localleader = "\\" -- Default localleader for keymaps
vim.g.border = "single" -- Default border for floating windows

vim.opt.textwidth = 80 -- Limit length of characters per line
vim.opt.tabstop = 4 -- Number of spaces to represent tab characters
vim.opt.softtabstop = 4 -- Number of spaces for tabs during edit operations
vim.opt.shiftwidth = 4 -- Number of spaces for expandtab indent
vim.opt.expandtab = true -- Convert tabs characters to spaces
vim.opt.shiftround = true -- Round indent to shift width
vim.opt.autoindent = false -- Auto apply indentation
vim.opt.smartindent = false -- Insert indents automatically
vim.opt.autoread = true -- Load changes made outside of Vim
vim.opt.autochdir = false -- Change working directory to active buffer
vim.opt.linebreak = true -- Split on line break
vim.opt.colorcolumn = "+1" -- Visually display character line limit
vim.opt.background = "dark" -- Adjusts the default color groups for background type
vim.opt.clipboard = { "unnamed", "unnamedplus" } -- Configure system clipboard support
vim.opt.cmdheight = 1 -- Command line character height
vim.opt.cmdwinheight = 5 -- Set size of command history buffer
vim.opt.conceallevel = 0 -- Determine how text with the "conceal" syntax is handled
vim.opt.cindent = false -- Indent using C indenting rules
vim.opt.wrap = false -- Wrap text when line is too long
vim.opt.hidden = true -- Hide modified buffers instead of unloading them
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.cursorlineopt = "number" -- Control how 'cursorline' is displayed
vim.opt.incsearch = true -- Enable incremental search
vim.opt.hlsearch = true -- Enable search highlighting
vim.opt.laststatus = 3 -- Apply statusline options
vim.opt.lazyredraw = true -- Execute macros faster
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.showmode = false -- Manage whether EOL message is shown
vim.opt.pumblend = 24 -- Pop-up menu transparency
vim.opt.pumheight = 12 -- Pop-up menu height
vim.opt.pumwidth = 16 -- Pop-up menu thickness
vim.opt.ruler = true -- Always show cursor position
vim.opt.scrolloff = 8 -- Keep cursor closer to center vertically
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.sidescrolloff = 2 -- Keep cursor closer to center horizontally
vim.opt.sidescroll = 1 -- Smoother horizontal scrolling
vim.opt.signcolumn = "yes:2" -- Sign gutter options: yes|no : int = size
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Override search if pattern contains uppercase
vim.opt.splitbelow = true -- Open new windows below current
vim.opt.splitright = true -- Open new windows right of current
vim.opt.termguicolors = true -- Enable true color support
vim.opt.timeout = true -- Time limit for key sequences
vim.opt.timeoutlen = 500 -- Timeout for mapped sequence
vim.opt.ttimeoutlen = 0 -- Timeout for key code sequence
vim.opt.updatetime = 50 -- Timeout idle before CursorHold or updating swapfile
vim.opt.belloff = "all" -- Events error bells will be suppressed
vim.opt.errorbells = false -- Produce audible error feedback
vim.opt.number = true -- Display absolute line number in gutter
vim.opt.relativenumber = true -- Display relative line number in gutter
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Make a backup before overwriting a file
vim.opt.writebackup = false -- Backup before overwriting a file
vim.opt.undofile = true -- Cache persistent undo

vim.opt.shortmess:append("cfI") -- Avoid 'hit-enter' prompts
vim.opt.whichwrap:append("<,>,[,]") -- Allows navigation wrapping to previous/next lines

-- Control vim Spell checking
vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.spelloptions = { "camel", "noplainbuffer" }

-- Insert mode completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Describes how auto-format is handled
-- See `:h fo-table` for details and more options
vim.opt.formatoptions = {
  c = false, -- Auto-wrap comments using 'textwidth'
  j = true, -- Remove comment leader when joining lines
  l = true, -- Long lines are not broken in insert mode
  n = true, -- Recognize numbered lists
  o = false, -- Insert comment leader after hitting 'o'
  q = true, -- Allow formatting of comments with "gq"
  r = false, -- Insert comment leader after hitting	<Enter>
  t = false, -- Auto-wrap text using 'textwidth'
}

-- Set what should be included in session files
vim.opt.sessionoptions = {
  "blank", -- Blank Buffers
  "buffers", -- Open Buffers
  "curdir", -- Current Directory
  "folds", -- Fold locations
  "globals", -- global variables
  "help", -- Vimdoc buffers
  "localoptions", -- Buffer local options
  "tabpages", -- Open Tab pages
  "terminal", -- Open Terminal
  "winpos", -- Window Positions
  "winsize", -- Window sizes
}

-- Start diff mode in vertical split
vim.opt.diffopt = {
  "closeoff", -- Exit diff on window close
  "filler", -- Render filler lines
  "foldcolumn:0", -- Set diff foldcolumn
  "internal", -- Use internal diff library
  "vertical", -- Split diff vertically
}

-- Define preferred font family for GUI clients
vim.opt.guifont = {
  "FiraCode NFM Retina:h12",
  "FiraCode NFM:h12",
  "CaskaydiaCove Nerd Font:h12",
  "CaskaydiaCove NF:h12",
}

--- Folding ---

-- Define how folded lines should be displayed
---@return string
function _G._foldtext()
  local foldstart = vim.fn.getline(vim.v.foldstart)
  local foldend = vim.fn.getline(vim.v.foldend)
  local linecount = vim.v.foldend - vim.v.foldstart + 1
  local tabwidth = string.rep(" ", vim.bo.tabstop)
  return table.concat({
    vim.fn.substitute(foldstart, "\t", tabwidth, "g"),
    "...",
    vim.fn.trim(foldend),
    string.format("[%s lines]", linecount),
  }, " ")
end

-- Apply buffer folding options
vim.opt.foldnestmax = 8 -- Max fold nest levels
vim.opt.foldminlines = 1 -- Minimum lines per fold
vim.opt.foldlevelstart = 9 -- We want all fold to be expand at start
vim.opt.foldlevel = 99 -- Set nested fold depth level
vim.opt.foldmethod = "expr" -- use treesitter for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = "v:lua._foldtext()"

--- Wildmenu ---

vim.opt.wildmenu = true -- Command-line completion
vim.opt.wildignorecase = true -- Case insensitive command-line completion
vim.opt.wildmode = "full:lastused" -- Command-line completion mode
-- Path patterns wild menu should ignore
vim.opt.wildignore = {
  "**/.git/*", -- Git Version control
  "**/.hg/*", -- Mercurial repo
  "**/.svn/*", -- Subversion repo
  "**/android/*", -- Google Android build
  "**/build/*", -- Generic build artifacts
  "**/coverage/*", -- Test coverage reports
  "**/ios/*", -- Apple iOS build
  "**/node_modules/*", -- Node module environment
  "**/out/*", -- Output directory
  "**/target/*", -- Target directory
  "**/tmp/*", -- Temp directory
  "*.DS_Store", -- MacOS finder metadata
  "*.pyc", -- Python byte code
  "*_build/*", -- Private build artifacts
}

-- Virtual Characters ---

-- Virtual strings to use in 'list' mode
vim.opt.list = true -- Enable listchars
vim.opt.showbreak = "↳" -- Display line wrap indicator
vim.opt.listchars = {
  eol = " ", -- End of line ↴
  extends = "❯", -- Horizontal overflow
  lead = " ", -- Leading whitespace
  multispace = " ", -- Consecutive whitespace
  nbsp = "␣", -- Non-breakable space
  precedes = "❮", -- Horizontal underflow
  space = " ", -- Standard Whitespace
  tab = "  »", -- Tab indentation
  trail = "·", -- Trailing whitespace
}

-- Virtual fill strings for UI elements
vim.opt.fillchars = {
  diff = "", -- Diff Removed
  eob = "~", -- End of Buffer
  fold = " ", -- Fold region
  foldclose = "▸", -- Fold closed
  foldopen = "▾", -- Fold open
  foldsep = "│", -- Fold operator
  msgsep = "─", -- Message separator
}

--- Colors ---

-- Global highlight overrides
vim.g.colors = {
  LspInfoBorder = { link = "FloatBorder" },
  MsgSeparator = { link = "VertSplit" },
  NormalFloat = { link = "Normal" },
}

--- Netrw ---

vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.g.netrw_liststyle = 3 -- Default to tree view
vim.g.netrw_localrmdir = "rm -r"

--- Neovide ---

-- Options that only apply to neovide GUI
if vim.g.is_neovide == 1 then
  vim.g.neovide_cursor_animation_length = 0.01
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_fullscreen = true
  vim.g.neovide_remember_window_size = true
end

--- Windows ---

-- Options that only apply to nt/windows
if vim.fn.has("win32") == 1 then
  -- Set default shell to PowerShell
  vim.opt.shell = vim.fn.executable("pwsh") and "pwsh" or "powershell"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellredir = "| Out-File -Encoding UTF8"
  vim.opt.shellquote = '"'
  vim.opt.shellxquote = ""
end
