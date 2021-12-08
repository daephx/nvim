local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

vim.api.nvim_echo({'Pre globals', 'WarningMsg'}, true, {})

-- Neoterm Options

g.neoterm_default_mod = 'botright'
g.neoterm_size = 25
g.neoterm_autoscroll = 1
g.neoterm_keep_term_open = 1
g.neoterm_autoinsert = 1
g.neoterm_fixedsize = 0


-- Shell preference

-- Helper ternary function
local function ternary(t, f, cond)
  if cond then return t else return f end
end

vim.api.nvim_echo({'After ternary', 'WarningMsg'}, true, {})

if fn.has('win32') then
  -- Use pwsh if available, else use windows powershell
  g.neoterm_shell = ternary('pwsh', 'powershell', fn.executable('pwsh'))
  g.neoterm_eof = '\r'
else -- Use whatever shell you prefer, default to bash
  g.neoterm_shell = ternary('zsh', 'bash', fn.executable('zsh'))
end

vim.api.nvim_echo({'After win32', 'WarningMsg'}, true, {})

-- Mappings

-- Spawn/Toggle Terminal
-- map('n', '<leader>`', '<cmd>Ttoggle<CR>', opts)
-- map('t', '<leader>`', '<C-\\><C-n>Ttoggle<CR>', opts)
map('n', '<F12>', '<cmd>Ttoggle<CR>', opts)
map('t', '<F12>', '<C-\\><C-n><cmd>Ttoggle<CR>', opts)

-- Allow Ctrl+W to switch window in terminal
map('t', '<C-w>', '<C-\\><C-n><C-w>', opts)


cmd [[
augroup neoterm_au
  autocmd!
  " Hide terminal from buffer list
  autocmd TermOpen,TermEnter * setlocal nobuflisted
  " Auto enter insert mode for terminal buffers
  " autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
  " autocmd TermOpen * tnoremap <buffer> <esc> <c-\><c-n>
augroup END
]]
