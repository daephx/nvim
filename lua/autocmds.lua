local api = vim.api

api.nvim_create_augroup('DisableSearchHighlight', { clear = true })
api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  desc = 'Disable search highlight when entering insert mode',
  group = 'DisableSearchHighlight',
  command = 'nohlsearch',
})
