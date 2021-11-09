local cmd = vim.cmd
local fn = vim.fn

local M = {}

--@param  group  : string = 'DiffAdd'
--@param  colors : table  = {'fg', 'gui'}
--@return color  : string = '#10e010'
function M.getHighlight(group, term)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), unpack(term))
end


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

  local hl = 'highlight '..group..' '..ui..' '..fg..' '..bg..' '..sp

  if colors.link then
    cmd('highlight! link '..group..' '..colors.link)
  else
    cmd(hl)
  end
end

return M
