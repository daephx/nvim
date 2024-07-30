-- Neovim general editor options/settings

vim.g.border = "single" -- Default border for floating windows
vim.g.localleader = "\\" -- Default localleader for keymaps
vim.g.mapleader = " " -- Default leader for keymaps

vim.opt.background = "dark" -- Adjusts the default color groups for background type
vim.opt.termguicolors = true -- Enable true color support

vim.opt.textwidth = 80 -- Limit length of characters per line
vim.opt.tabstop = 4 -- Number of spaces to represent tab characters
vim.opt.softtabstop = 4 -- Number of spaces for tabs during edit operations
vim.opt.shiftwidth = 4 -- Number of spaces for expandtab indent
vim.opt.expandtab = true -- Convert tabs characters to spaces
vim.opt.shiftround = true -- Round indent to shift width

vim.opt.number = true -- Display absolute line number in gutter
vim.opt.relativenumber = true -- Display relative line number in gutter
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.cursorlineopt = "both" -- Control how 'cursorline' is displayed
vim.opt.colorcolumn = "+1" -- Visually display character line limit
vim.opt.signcolumn = "yes:2" -- Sign gutter options: yes|no : int = size
vim.opt.scrolloff = 8 -- Keep cursor closer to center vertically
vim.opt.sidescrolloff = 8 -- Keep cursor closer to center horizontally
vim.opt.laststatus = 3 -- Apply statusline options
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.cmdwinheight = 5 -- Set size of command history buffer
vim.opt.winminwidth = 5 -- The minimal width for windows

vim.opt.mouse = "a" -- Enable mouse support
vim.opt.wrap = false -- Wrap text when line is too long
vim.opt.breakindent = true -- Indent the start of wrapped lines
vim.opt.linebreak = true -- Split on line break
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Override search if pattern contains uppercase

vim.opt.autoread = true -- Load changes made outside of Vim
vim.opt.showmode = false -- Manage whether EOL message is shown
vim.opt.splitbelow = true -- Open new windows below current
vim.opt.splitright = true -- Open new windows right of current
vim.opt.splitkeep = "screen" -- Determines the scroll behavior for horizontal splits

vim.opt.timeoutlen = 250 -- Timeout for mapped sequence
vim.opt.ttimeoutlen = 0 -- Timeout for key code sequence
vim.opt.updatetime = 1000 -- Timeout idle before CursorHold or updating swapfile
vim.opt.swapfile = false -- Use a swapfile for the current buffer
vim.opt.undofile = true -- Cache persistent undo
vim.opt.undolevels = 10000 -- Maximum number of changes that can be undone

-- Popup menu options
vim.opt.pumblend = 0 -- Pop-up menu transparency
vim.opt.pumheight = 12 -- Pop-up menu height
vim.opt.pumwidth = 16 -- Pop-up menu thickness

-- Control vim Spell checking
vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.spelloptions = { "camel", "noplainbuffer" }

-- Insert mode completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Configure system clipboard support
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- Enable cursor blinking
vim.opt.guicursor:append("n-v-c:blinkon500-blinkoff500")

-- Define preferred font family for GUI clients
vim.opt.guifont = {
  "FiraCode NFM:h12",
  "CascadiaCode NFM:h12",
  "Hack NFM:h12",
}

-- Allows navigation wrapping to previous/next lines
vim.opt.whichwrap:append("<,>,[,]")

-- Avoid 'hit-enter' prompts
vim.opt.shortmess:append({
  C = true, -- Don't give messages while scanning for ins-completion items
  I = true, -- Don't give the intro message when starting Vim
  c = true, -- Don't give ins-completion-menu messages
  f = true, -- Use "(3 of 5)" instead of "(file 3 of 5)"
})

-- Describes how auto-format is handled
-- See `:h fo-table` for details and more options
vim.opt.formatoptions = {
  c = true, -- Auto-wrap comments using 'textwidth'
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
  "algorithm:histogram", -- Set diff algorithm
  "closeoff", -- Exit diff on window close
  "context:4", -- Context between folds
  "filler", -- Render filler lines
  "foldcolumn:0", -- Set diff foldcolumn
  "hiddenoff", -- Disable for hidden buffers
  "indent-heuristic", -- Use indent heuristic
  "internal", -- Use internal diff library
  "linematch:60", -- Align hunk lines
  "vertical", -- Split diff vertically
}

-- Apply buffer folding options
vim.opt.foldcolumn = "0" -- Disable fold column
vim.opt.foldlevel = 99 -- Set nested fold depth level
vim.opt.foldlevelstart = 99 -- We want all fold to be expand at start
vim.opt.foldmethod = "expr" -- use treesitter for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = "v:lua.require('config.util').foldtext()"

-- Specifies for which type of commands folds will be opened
vim.opt.foldopen = {
  -- "all", -- Any
  -- "block", -- (, {, [[, [{, etc.
  "hor", -- Horizontal movements: "l", "w", "fx", etc.
  "insert", -- Any command in Insert mode
  "jump", -- Far jumps: "G", "gg", etc.
  "mark", -- Jumping to a mark: "'m", CTRL-O, etc.
  "percent", -- Jump to matching item "%"
  "quickfix", -- ":cn", ":crew", ":make", etc.
  "search", -- Search for a pattern: "/", "n", "*", "gd", etc.
  "tag", -- Jumping to a tag: ":ta", CTRL-T, etc.
  "undo", -- Undo or redo: "u" and CTRL-R
}

-- Wildmenu options
vim.opt.wildmenu = false -- Command-line completion
vim.opt.wildignorecase = true -- Case insensitive command-line completion
vim.opt.wildmode = "full:lastused" -- Command-line completion mode
vim.opt.wildoptions = "pum" -- change how cmdline-completion is done
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

-- Virtual strings to use in 'list' mode
vim.opt.list = true -- Enable listchars
vim.opt.showbreak = "↳" -- Display line wrap indicator
vim.opt.listchars = {
  eol = " ", -- End of line ↴
  extends = ")", -- Horizontal overflow
  lead = " ", -- Leading whitespace
  multispace = " ", -- Consecutive whitespace
  nbsp = "␣", -- Non-breakable space
  precedes = "(", -- Horizontal underflow
  space = " ", -- Standard Whitespace
  tab = "  →", -- Tab indentation
  trail = "·", -- Trailing whitespace
}

-- Virtual fill strings for UI elements
vim.opt.fillchars = {
  diff = "", -- Diff Removed
  eob = "~", -- End of Buffer
  fold = " ", -- Fold region
  foldclose = "", -- Fold closed
  foldopen = "", -- Fold open
  msgsep = "─", -- Message separator
  stl = " ", -- Statusline current
  stlnc = " ", -- Statusline non-current
}

-- Global highlight overrides
vim.g.colors = {
  LspInfoBorder = { link = "FloatBorder" },
  MsgSeparator = { link = "VertSplit" },
  NormalFloat = { link = "Normal" },
}

-- Netrw specific options
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.g.netrw_liststyle = 3 -- Default to tree view
vim.g.netrw_localrmdir = "rm -r"

-- Options that only apply to neovide GUI
if vim.g.is_neovide == 1 then
  vim.g.neovide_cursor_animation_length = 0.01
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_fullscreen = true
  vim.g.neovide_remember_window_size = true
end

-- Set default shell to PowerShell in nt/windows
if vim.fn.has("win32") == 1 then
  vim.opt.shell = vim.fn.executable("pwsh") and "pwsh" or "powershell"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellredir = "| Out-File -Encoding UTF8"
  vim.opt.shellquote = '"'
  vim.opt.shellxquote = ""
end
