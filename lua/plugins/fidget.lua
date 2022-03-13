local M = {}

local fidget = require('fidget')

fidget.setup({
  text = {
    -- animation shown when tasks are ongoing
    spinner = 'dots',
  },
  window = {
    relative = 'editor',
  },
  fmt = {
    -- function to format fidget title
    fidget = function(fidget_name, spinner)
      return string.format('%s %s', fidget_name, spinner)
    end,
  },
})

vim.cmd([[highlight FidgetTitle ctermfg=110 guifg=#6cb6eb]])

return M
