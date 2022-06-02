local api = vim.api

api.nvim_create_augroup('DisableSearchHighlight', { clear = true })
api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  desc = 'Disable search highlight when entering insert mode',
  group = 'DisableSearchHighlight',
  command = 'nohlsearch',
})

api.nvim_create_augroup('SmartHybridNumbers', { clear = true })
api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  desc = 'Intelligent Relative Numbers | Enable',
  group = 'SmartHybridNumbers',
  command = 'if &nu && mode() != "i" | set rnu | endif',
})

api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  desc = 'Intelligent Relative Numbers | Disable',
  group = 'SmartHybridNumbers',
  command = 'if &nu | set nornu | endif',
})
