local api = vim.api

api.nvim_create_augroup('FocusIssues', { clear = true })
api.nvim_create_autocmd({ 'BufEnter', 'WinLeave', 'FocusLost', 'VimSuspend' }, {
  desc = 'Leave insert or replace mode on focus loss',
  group = 'FocusIssues',
  pattern = '*',
  command = 'if empty(&buftype) | stopinsert | endif',
})

api.nvim_create_autocmd({ 'FocusLost' }, {
  desc = 'Write all buffers on FocusLost',
  group = 'FocusIssues',
  command = 'silent! wall ',
})

api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  desc = 'Update current buffer on CursorHold/I',
  group = 'FocusIssues',
  command = 'silent! update',
})

api.nvim_create_augroup('ReloadVimRC', { clear = true })
api.nvim_create_autocmd('BufWritePost', {
  desc = 'Auto-sourcing Configurations',
  group = 'ReloadVimRC',
  pattern = vim.env.MYVIMRC,
  callback = function()
    vim.notify(string.format("Reloading $MYVIMRC: '%s'", vim.env.MYVIMRC))
    vim.cmd(vim.env.MYVIMRC)
  end,
})

api.nvim_create_augroup('DisableSearchHighlight', { clear = true })
api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  desc = 'Disable search highlight when entering insert mode',
  group = 'DisableSearchHighlight',
  command = 'nohlsearch',
})

api.nvim_create_augroup('YankHighlight', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight the region on yank',
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 500 })
  end,
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

api.nvim_create_augroup('TerminalBuffers', {})
api.nvim_create_autocmd('TermOpen', {
  desc = '',
  group = 'TerminalBuffers',
  pattern = 'term://*',
  callback = function()
    vim.opt_local.buflisted = true
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.spell = false
    vim.opt_local.scrolloff = 0
    vim.opt_local.winfixheight = true
  end,
})

api.nvim_create_autocmd('TermClose', {
  desc = 'Skip prompt, Automatically close exited terminal buffer processes',
  group = 'TerminalBuffers',
  pattern = 'term://*',
  callback = function()
    vim.fn.feedkeys('i')
    vim.api.nvim_input('<esc>')
  end,
})

api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
  desc = 'Automatically enter insert mode when focusing a terminal buffer',
  group = 'TerminalBuffers',
  pattern = 'term://*',
  command = 'startinsert',
})

api.nvim_create_autocmd({ 'TermClose', 'BufLeave' }, {
  desc = 'Disable insert mode when leaving a terminal buffer',
  group = 'TerminalBuffers',
  pattern = 'term://*',
  command = 'stopinsert',
})
