-- barbecue.nvim | A VS Code like winbar for Neovim
-- https://github.com/utilyre/barbecue.nvim

local function icons()
  return vim.tbl_map(function(icon)
    return icon
  end, require("core.icons").kinds)
end

return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    -- Code context for winbar/statusline
    "SmiteshP/nvim-navic",
    -- Adds file type icons to Vim plugins
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    kinds = icons(),
    show_modified = true,
    attach_navic = false,
    exclude_filetypes = {
      "",
      "dashboard",
      "git",
      "gitcommit",
      "terminal",
      "toggleterm",
    },
    theme = {
      separator = { link = "LineNr" },
    },
  },
}
