-- hop.nvim | Neovim motions on speed!
-- https://github.com/smoka7/hop.nvim

local search_line = function()
  require("hop").hint_char1({
    current_line_only = true,
    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
  })
end

local search_buffer = function()
  require("hop").hint_char1({ current_line_only = false })
end

---@type LazyPluginSpec
return {
  "smoka7/hop.nvim",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  config = true,
  keys = {
    { "f", search_line, desc = "Hop line" },
    { "F", search_buffer, desc = "Hop buffer" },
  },
}
