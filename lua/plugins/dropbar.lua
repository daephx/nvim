-- dropbar.nvim | IDE-like breadcrumbs, out of the box:
-- https://github.com/Bekaboo/dropbar.nvim

---@type LazySpec
return {
  "Bekaboo/dropbar.nvim",
  event = { "BufNewFile", "BufReadPost" },
  -- stylua: ignore
  keys = {
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Pick symbols in winbar" },
    { "[;", function() require("dropbar.api").goto_context_start() end, desc = "Go to start of current context" },
    { "];", function() require("dropbar.api").select_next_context() end, desc = "Select next context" },
  },
  ---@module "dropbar"
  ---@type dropbar_opts_t
  opts = {
    kinds = {
      symbols = require("config.icons").kinds,
    },
  },
}
