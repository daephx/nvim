local fn = vim.fn


local M = {}


function M.getHighlightTable(group)

  local output = fn.execute('hi ' .. group)
  local list = fn.split(output, '\\s\\+')

  local dict = {}
  for _, item in pairs(list) do
    if fn.match(item, '=') > 0 then
      local splited = fn.split(item, '=')
      dict[splited[1]] = splited[2]
    end
  end
  return dict
end


-- TODO: Allow extraction of linked values and overwriting, aka partialLinks
--@param group  : string = 'DiffAdd'
--@param colors : table  = {fg = '#10e010'}
function M.setHighlight(group, colors)

  local bg = colors.bg and 'guibg=' .. colors.bg or ''
  local fg = colors.fg and 'guifg=' .. colors.fg or ''
  local sp = colors.sp and 'guisp=' .. colors.sp or ''
  local ui = colors.ui and 'gui='   .. colors.ui or ''

  local hl = 'silent highlight ' .. table.concat({group, bg, fg, sp, ui}, " ")

  if colors.clear == true then
    vim.cmd('highlight clear ' .. group)
    return
  end
  if colors.link then
    link = table.concat({'link', group, colors.link}, ' ')
    vim.cmd('highlight! ' .. link)
  end
  vim.cmd(hl)
end


function M.setup(opts)
  local next = next
  opts = type(opts) == 'function' and opts() or opts
  for group, colors in pairs(opts) do
    if next(colors) ~= nil then
      M.setHighlight(group, colors)
    end
  end
end


return M
