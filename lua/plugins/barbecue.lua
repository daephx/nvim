-- barbecue.nvim | A VS Code like winbar for Neovim
-- https://github.com/utilyre/barbecue.nvim
local barbecue_ok, barbecue = pcall(require, "barbecue")
if not barbecue_ok then
  return
end

local function icons()
  return vim.tbl_map(function(icon)
    return icon
  end, require("plugins.lsp.icons").kinds)
end

barbecue.setup({
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
})
