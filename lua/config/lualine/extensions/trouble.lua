local function trouble_statusline()
  return 'Trouble'
end

local function trouble_itemcount()
  return #require('trouble').get_items()
end

local M = {}

M.sections = {
  lualine_a = { trouble_statusline },
  -- lualine_b = { trouble_itemcount },
  lualine_z = { trouble_itemcount, 'location' },
}

M.inactive_sections = {}

M.filetypes = { 'Trouble' }

return M
