-- nvim-navic | winbar/statusline that shows your current code context
-- https://github.com/SmiteshP/nvim-navic
local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then
  return
end

local function icons()
  return vim.tbl_map(function(icon)
    return icon .. " "
  end, require("plugins.lsp.icons").kinds)
end

navic.setup({
  icons = icons(),
  highlight = true,
  depth_limit = 5,
  separator = "  ",
  depth_limit_indicator = "…",
})
