--    _____      __  __  _
--   / ___/___  / /_/ /_(_)___  ____ ______
--   \__ \/ _ \/ __/ __/ / __ \/ __ `/ ___/
--  ___/ /  __/ /_/ /_/ / / / / /_/ (__  )
-- /____/\___/\__/\__/_/_/ /_/\__, /____/
--                           /____/
-- Module: settings
-- Description: settings / options for NeoVim
-- Equivulent to 'set'

--- Initialization ---

local cmd = vim.cmd
local g = vim.g

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
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
