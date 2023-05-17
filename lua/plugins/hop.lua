-- hop.nvim | Neovim motions on speed!
-- https://github.com/phaazon/hop.nvim

return {
  "phaazon/hop.nvim",
  branch = "v2",
  event = { "BufReadPost", "BufNewFile" },
  config = function(_, opts)
    local hop = require("hop")
    local hint = require("hop.hint")
    hop.setup(opts)

    vim.keymap.set("n", "f", function()
      hop.hint_char1({
        direction = hint.HintDirection.AFTER_CURSOR,
        current_line_only = true,
      })
    end, { desc = "Hop line" })

    vim.keymap.set("n", "F", function()
      hop.hint_char1({
        current_line_only = false,
      })
    end, { desc = "Hop buffer" })
  end,
}
