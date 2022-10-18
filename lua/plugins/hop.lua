-- hop.nvim | Neovim motions on speed!
-- https://github.com/phaazon/hop.nvim
local hop_ok, hop = pcall(require, 'hop')
if not hop_ok then
  return
end

local hint = require('hop.hint')

--- Setup ---

-- Hop config is fairly minimal,
-- Simply calling the setup function is sufficient

hop.setup({})

--- Keymaps ---

vim.keymap.set('n', 'f', function()
  hop.hint_char1({
    direction = hint.HintDirection.AFTER_CURSOR,
    current_line_only = true,
  })
end, { desc = 'Hop line' })

vim.keymap.set('n', 'F', function()
  hop.hint_char1({
    current_line_only = false,
  })
end, { desc = 'Hop buffer' })
