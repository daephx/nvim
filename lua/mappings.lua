-- Module: mappings
-- Description: Define key mappings for lua config

local api = vim.api

--- Mappings ---

-- Visually move lines <Up/Down>
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Make Y act like other capitals
map('n', 'Y', 'y$')

-- Black hole Registers
-- Breaks default functionality
map('v', '<del>', '"_d') -- Prevent <Delete> from yanking

-- Ctrl - hjkl to navigate splits
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-k>', '<cmd>wincmd k<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')

-- Visual indentation
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Formatting
-- TODO: Better formatting, check if lsp attachedm else rely on cmd / formatter.nvim
map('n', 'ff', '<cmd>lua vim.lsp.buf.formatting()<CR>') -- Activate LSP buffer formatter

-- Quickfix
map('n', '<c-q>', '<cmd>call ToggleQFList(1)<CR>')
map('n', '<localleader>q', '<cmd>call ToggleQFList(1)<CR>')
map('n', '<c-k>', '<cmd>cprev<CR>zz')
map('n', '<c-j>', '<cmd>cnext<CR>zz')

--- Terminal ---
map('t', '<leader><esc>', '<c-\\><c-n>') -- Double escape terminal mode
map('n', '<c-\\>', '<cmd>ToggleTerm direction=tab<CR>') -- Toggle tab terminal
map('n', '<c-\\><c-\\>', '<cmd>ToggleTerm direction=horizontal<CR>') -- Toggle horizontal terminal
map('t', '<c-\\>', '<c-\\><c-n><cmd>ToggleTerm<CR>') -- Escape and untoggle in terminal mode
map('t', '<c-w>', '<c-\\><c-n><c-w>') -- Allow Ctrl+W to switch window in terminal mode
-- map('t', '<c-r>', '<c-r>')

map('n', '<c->`', '<cmd>ToggleTerm direction=horizontal<CR>') -- Toggle horizontal terminal

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
-- cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Diffsplit
-- map('n', 'q', "&diff ? '<cmd>tabclose<CR>' : 'q'")
vim.cmd([[ nnoremap <expr> q &diff ? '<cmd>tabclose<CR>' : 'q' ]])

--- Whichkey ---

-- Check for whichkey plugin
local ok, wk = pcall(require, 'which-key')
if not ok then
  return
end

local whichkey_map = {}

-- General
whichkey_map = {
  name = '+Whichkey',
  ['<Space>'] = { '<cmd>Telescope buffers<CR>', 'Open Buffers' },
  ['?'] = { 'Cheatsheet' },
  ['/'] = { '<Plug>kommentary_line_default', 'Comment Line' },
  P = { 'which_key_ignore' },
  e = { '<cmd>NvimTreeToggle<cr>', 'Toggle NvimTree' },
  q = { 'LSP Set Location List' },
}

-- Debug Protocol
whichkey_map.d = {
  name = '+Debug',
  b = { '<cmd>lua require("dap").toggle_breakpoint()<CR>', 'Set Breakpoint' },
  d = { '<cmd>lua require("dap.python").attach_python_debugger()<CR>', 'Start Debugging' },
  n = { '<cmd>lua require("dap").continue()<CR>', 'Continue debugging' },
}

-- Telescope Find
whichkey_map.f = {
  name = '+Files',
  ['.'] = { '<cmd>lua require("plugins.telescope").search_dotfiles()<CR>', 'Dotfiles' },
  ['<S-c>'] = { '<cmd>Telescope commands<CR>', 'Commands' },
  ['<S-f>'] = { '<cmd>Telescope treesitter<CR>', 'Treesitter' },
  b = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', 'Grep Buffer' },
  c = { '<cmd>Telescope colorscheme<CR>', 'ColorSchemes' },
  d = { '<cmd>Telescope lsp_document_diagnostics<CR>', 'LSP Diagnostics' },
  e = { '<cmd>Telescope file_browser<CR>', 'File Explorer' },
  f = { '<cmd>Telescope find_files<CR>', 'Current Files' },
  h = { '<cmd>Telescope highlights<CR>', 'Highlight Groups' },
  l = { '<cmd>Telescope live_grep<CR>', 'Live Grep' },
  m = { '<cmd>Telescope marks<CR>', 'Bookmarks' },
  p = { '<cmd>Telescope projects<CR>', 'Project list' },
  r = { '<cmd>Telescope oldfiles<CR>', 'Recent Files' },
  s = { '<cmd>Telescope grep_string<CR>', 'Grep String' },
  t = { '<cmd>TodoTelescope<CR>', 'Search Todo comments' },
  v = { '<cmd>lua require("plugins.telescope").search_vimfiles()<CR>', 'VimRC' },
  w = { '<cmd>lua require("plugins.telescope").search_wikifiles()<CR>', 'Wiki' },
}

-- Plugins
whichkey_map.p = {
  name = '+Plugins',
  c = { '<cmd>PackerCompile<CR>', 'Compile Plugins' },
  s = { '<cmd>PackerStatus<CR>', 'Plugins status' },
  u = { '<cmd>PackerCompile<CR><cmd>PackerSync<CR>', 'Update Plugins' },
}

-- Git
whichkey_map.g = {
  name = '+Git',
  G = { '<cmd>lua require("neogit").open()<CR>', 'Git Status (Neogit)' },
  b = { '<cmd>lua require("plugins.telescope").git_branches()<CR>', 'Git branches' },
  d = { '<cmd>Gdiffsplit<CR>', 'Diff current buffer' },
  f = { '<cmd>Telescope git_files<CR>', 'Git files' },
  g = { '<cmd>Gtabedit :<CR>', 'Git Status (Fugitive)' },
  l = { '<cmd>GclogTab<CR>', 'Git Log' },
  z = { '<cmd>lua require("plugins.toggleterm").lazygit:toggle()<CR>', 'Lazygit' },
}

-- New
whichkey_map.n = {
  name = '+New',
  t = { '<cmd>tabnew<CR>', 'New tab' },
  f = { '<cmd>enew<CR>', 'New file' },
}

-- Sessions
whichkey_map.s = {
  name = '+Session',
  d = { '<cmd>DeleteSession<CR>', 'Delete current session' },
  l = { '<cmd>Telescope session-lens search_session<CR>', 'Load last session' },
  s = { '<cmd>SessionSave<CR>', 'Save current session' },
}

-- Terminal
whichkey_map.t = {
  name = '+Terminal',
  t = { '<cmd>ToggleTerm direction=tab<CR>', 'Terminal Tab' },
  d = { '<cmd>lua require("plugins.toggleterm").lazydocker:toggle()<CR>', 'Lazydocker' },
  g = { '<cmd>lua require("plugins.toggleterm").lazygit:toggle()<CR>', 'Lazygit' },
}

-- Register Keymap
wk.register(whichkey_map, { prefix = '<Leader>' })
