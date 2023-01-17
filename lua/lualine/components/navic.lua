-- Lualine component for nvim-navic, lsp symbol navigation
-- https://github.com/SmiteshP/nvim-navic
local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then
  return
end

local Navic = require("lualine.component"):extend()

local default_options = {
  cond = navic.is_available,
}

function Navic:init(options)
  Navic.super.init(self, options)
  options.colors = self.extend(self, "colors")
  self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)
end

function Navic:update_status()
  local none_display = ""
  if navic.is_available() then
    local loc = navic.get_location()
    return (loc ~= "") and loc or none_display
  else
    return none_display
  end
end

return Navic
