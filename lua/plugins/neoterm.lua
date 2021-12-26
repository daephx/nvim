local fn = vim.fn
local g = vim.g

-- Helper function: ternary condition
local function ternary(t, f, cond)
  if cond then return t else return f end
end


--- Globals ---

g.neoterm_default_mod = 'botright'
g.neoterm_size = 25
g.neoterm_autoscroll = 1
g.neoterm_keep_term_open = 1
g.neoterm_autoinsert = 1
g.neoterm_fixedsize = 0

-- Shell perferences
if fn.has('win32') then
  -- Use pwsh if available, else use windows powershell
  g.neoterm_shell = ternary('pwsh', 'powershell', fn.executable('pwsh'))
  g.neoterm_eof = '\r'
else -- Use whatever shell you prefer, default to bash
  g.neoterm_shell = ternary('zsh', 'bash', fn.executable('zsh'))
end


--- Mappings ---

-- Spawn/Toggle Terminal
map('n', '<F12>', '<cmd>Ttoggle<CR>')
map('t', '<F12>', '<C-\\><C-n><cmd>Ttoggle<CR>')

-- Allow Ctrl+W to switch window in terminal
map('t', '<C-w>', '<C-\\><C-n><C-w>')


--- Autocmds ---

vim.cmd([[
augroup neoterm_au
  autocmd!

  " Hide terminal from buffer list
  autocmd TermOpen,TermEnter * setlocal nobuflisted

  " Auto enter insert mode for terminal buffers
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

augroup END
]])
