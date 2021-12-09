local function short_mode(str)
  return str:sub(1,1)
end

local get_mode = require('lualine.components.mode').get_mode
local base_config = require('lualine').get_config()
require('lualine.components.mode').get_mode = short_mode(get_mode)

local M = {}

M.sections = table.insert(base_config.sections, short_mode(get_mode))

return M
