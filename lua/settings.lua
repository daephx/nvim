--    _____      __  __  _
--   / ___/___  / /_/ /_(_)___  ____ ______
--   \__ \/ _ \/ __/ __/ / __ \/ __ `/ ___/
--  ___/ /  __/ /_/ /_/ / / / / /_/ (__  )
-- /____/\___/\__/\__/_/_/ /_/\__, /____/
--                           /____/
-- Module: settings
-- Description: settings / options for NeoVim

--- Initialization ---

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- Set reusable values
local encode = 'utf-8'                         -- Default File encoding
local indent = 2                               -- Default indentation
local linelimit = 102                          -- Default Limit for line length

-- Apply Settings
opt.exrc = true                                -- Source init file from project
opt.autoread = true                            -- Load changes made outside of Vim
opt.autochdir = false                          -- Disable auto cd to open file
opt.smartindent = true                         -- Insert indents automatically
opt.autoindent = true                          -- Auto apply indentation
opt.expandtab = true                           -- Use spaces instead of tabs
opt.shiftround = true                          -- Round indent to shiftwidth
opt.tabstop = indent                           -- Number of spaces for tab count
opt.softtabstop = indent
opt.shiftwidth = indent                        -- Size of an indent
opt.encoding = encode                          -- Explicitly set file encoding
opt.fileencoding = encode
opt.textwidth = linelimit                      -- Limit length of characters in a line
opt.linebreak = true                           -- Split on linebreak
opt.colorcolumn = '+1'                         -- Visually display character line limit
opt.background = 'dark'
opt.clipboard = 'unnamed,unnamedplus'          -- Use system clipboard
opt.cmdheight = 1                              -- Commandline character height
opt.conceallevel = 0
opt.foldmethod = 'indent'                      -- Fold by method (indent & syntax are both good
opt.foldlevelstart = 9                         -- We want all fold to be expand at start
opt.foldnestmax = 9                            -- Max fold nest levels
opt.cindent = true
opt.wrap = false                               -- Wrap text when line is too long
opt.hidden = true                              -- Hide modified buffers instead of unloading them
opt.cursorline = true                          -- Highlight the text line of the cursor
opt.incsearch = true                           -- Enable incrimental search
opt.hlsearch = true                            -- Highlight search
opt.laststatus = 2                             -- Always show statusline
opt.lazyredraw = false                         -- Execute macros faster
opt.mouse = 'a'                                -- Enable mouse support
opt.showmode = false                           -- No eol message
opt.pumblend = 24                              -- Popup menu transparency
opt.pumheight = 12                             -- Popup menu height
opt.pumwidth = 16                              -- Popup menu thickness
opt.ruler = true                               -- Always Show cursor position
opt.scrolloff = 8                              -- Keep cursor closer to center
opt.showtabline = 2                            -- Always show tabline
opt.sidescrolloff = 8                          -- Columns of context
opt.sidescroll = 1                             -- Smoother horizontal scrolling
opt.signcolumn = 'yes'                         -- Sign gutter options: 'yes', 'number'
opt.ignorecase = true                          -- Case insensitive search
opt.smartcase = true                           -- Don't ignore case with capitals
opt.splitbelow = true                          -- Put new windows below current
opt.splitright = true                          -- Put new windows right of current
opt.termguicolors = true                       -- True color support
opt.timeout = true                             -- time limit for key sequences
opt.timeoutlen = 500                           -- Wait for a mapped sequence
opt.ttimeoutlen = 0                            -- Instant timeout for terminal buffer
opt.updatetime = 750                           -- Time in milliseconds before update
opt.errorbells = false                         -- Produce noise on error
opt.number = true                              -- Print line number
opt.relativenumber = true                      -- Print relative line numbers
opt.swapfile = false                           -- Disable swap files
opt.backup = false                             -- Make a backup before overwriting a file
opt.writebackup = false                        -- backup before overwriting a file
opt.undofile = true                            -- Persistant undo
opt.undolevels = 1000                          -- Maximum number of undoable changes
opt.undoreload = 10000                         -- Save the whole buffer for undo
opt.wildmenu = true

opt.completeopt = 'menuone,noinsert,noselect'  -- Insert mode completion

opt.formatoptions:append('tcrqnj')                  -- describes how auto-format is handled
opt.diffopt:append({'vertical'})                    -- Start diff mode in vertical split
opt.shortmess:append('cfI')                         -- Avoid 'hit-enter' prompts
opt.whichwrap:append('<,>,[,],h,l')
opt.wildmode:append('full:lastused')                -- Command-line completion mode
opt.wildignore:append({
  '**/.git/*',          -- Git Version control
  '**/android/*',
  '**/build/*',         -- Common build directory
  '**/coverage/*',
  '**/ios/*',
  '**/node_modules/*',  -- Node module environment
  '*.pyc',              -- Python cache'
  '*_build/*'
})

-- ListChars

opt.list = true
opt.listchars = {}
-- opt.listchars:append('eol:¬')
-- opt.listchars:append('tab:░\\')
opt.listchars:append('extends:»')
opt.listchars:append('nbsp:⣿')
opt.listchars:append('precedes:«')
opt.listchars:append('trail:·')


-- Fonts
opt.guifont:append('CaskaydiaCove\\ Nerd\\ Font:h16') -- Prefered fonts


--- Windows ---

-- These settings apply only to nt/windows

if fn.has('win32') == 1 then
  cmd([[ " Set default shell to powershell
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    set shellquote= shellpipe=\| shellxquote=
    set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
  ]])
end

local encode = 'utf-8'                                -- Default File encoding
local indent = 2                                      -- Default indentation

opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('o', 'autoread', true)
opt('o', 'autochdir', false)
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'background', 'dark' )
opt('o', 'clipboard', 'unnamed,unnamedplus')          -- Use system clipboard
opt('o', 'cmdheight', 1)
opt('o', 'completeopt', 'menuone,noselect')           -- Completion options (for compe)
opt('o', 'conceallevel', 0)
opt('o', 'cursorline', true)
opt('o', 'encoding', encode)
opt('o', 'fileencoding', encode)
opt('b', 'formatoptions', 'tcrqnj')
opt('o', 'hidden', true)                              -- Enable modified buffers in background
-- opt('o', 'shortmess', gsub('c', ''))
opt('o', 'incsearch', true)
opt('o', 'laststatus', 2)
opt('o', 'lazyredraw', true)
opt('o', 'mouse', 'a')
opt('o', 'backup', false)
opt('o', 'showmode', false)
opt('o', 'wrap', false)
opt('o', 'writebackup', false)
opt('o', 'pumblend', 25 )
opt('o', 'pumheight', 10 )
opt('o', 'ruler', true)
opt('o', 'scrolloff', 8 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'showtabline', 2)
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'signcolumn', 'number')
opt('o', 'ignorecase', true)
opt('o', 'cindent', true)
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'swapfile', false)                           -- Disable swap files
-- opt('o', 't_Co', '256')                                 -- Support 256 Colors
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'timeoutlen', 500)
opt('o', 'ttimeoutlen', 0)
opt('o', 'updatetime', 750)                           -- Time in milliseconds before update
-- opt('o', 'whichwrap', '<,>,[,],h,l')
-- opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('o', 'number', true)                              -- Print line number
opt('o', 'relativenumber', true)                      -- Print relative line numbers
opt('o', 'undofile', true)                            -- Persistant undo


opt('o', 'guifont', 'CaskaydiaCove\\ Nerd\\ Font:h16')


-- NeoVide Settings

if g.is_neovide == 1 then
  g.neovide_fullscreen = true
  g.neovide_cursor_vfx_mode = "pixiedust"
end
