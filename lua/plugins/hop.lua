-- hop.nvim | Neovim motions on speed!
-- https://github.com/phaazon/hop.nvim

return {
  "phaazon/hop.nvim",
  branch = "v2",
  event = { "BufReadPost", "BufNewFile" },
  config = true,
  keys = {
    {
      "f",
      function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        })
      end,
      desc = "Hop line",
    },
    {
      "F",
      function()
        require("hop").hint_char1({ current_line_only = false })
      end,
      desc = "Hop buffer",
    },
  },
}
