-- barbecue.nvim | A VS Code like winbar for Neovim
-- https://github.com/utilyre/barbecue.nvim

local function icons()
  return vim.tbl_map(function(icon)
    return icon
  end, require("plugins.lsp.icons").kinds)
end

return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    kinds = icons(),
    show_modified = true,
    attach_navic = false,
    exclude_filetypes = {
      "dashboard",
      "gitcommit",
      "terminal",
      "toggleterm",
    },
    theme = {
      separator = { fg = "gray" },
    },
  },
}
