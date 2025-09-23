-- dropbar.nvim | IDE-like breadcrumbs, out of the box:
-- https://github.com/Bekaboo/dropbar.nvim

---@type LazySpec
return {
  "Bekaboo/dropbar.nvim",
  event = { "BufNewFile", "BufReadPost" },
  dependencies = {
    -- optional, but required for fuzzy finder support
    -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  ---@module "dropbar"
  opts = {
    kinds = {
      symbols = require("config.icons").kinds,
    },
  },
  config = function(_, opts)
    require("dropbar").setup(opts)
    local dropbar_api = require("dropbar.api")
    require("config.util").register_keymaps(nil, {
      { "n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" } },
      { "n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" } },
      { "n", "];", dropbar_api.select_next_context, { desc = "Select next context" } },
    })
  end,
}
