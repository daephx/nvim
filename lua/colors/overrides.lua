local cmd = vim.cmd
local g = vim.g

local utils = require('colors.utils')

local M = {}


--@param table : table = {opt = bool, highlights = {}}
function M.setup(table)

  -- Set color values
  for group, colors in pairs(table.highlights) do
    utils.setHighlight(group, colors)
  end

  -- Remove background color / transparency
  -- NOTE: Check if your colorscheme also has similar options
  if table.transparent_background then
    utils.setHighlight('Normal', {bg = 'NONE'})
  end

  -- Enable/Disable italics for comment strings
  if table.italic_comments then
    utils.setHighlight('Comments', {ui = 'italic'})
  else
    utils.setHighlight('Comments', {ui = 'none'})
  end

return M
