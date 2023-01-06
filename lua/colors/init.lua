--    ______      __
--   / ____/___  / /___  __________
--  / /   / __ \/ / __ \/ ___/ ___/
-- / /___/ /_/ / / /_/ / /  (__  )
-- \____/\____/_/\____/_/  /____/
-- ================================
-- init module for loading colorschemes
-- and overrides for common highlight groups

local g = vim.g

local M = {}

--- Highlights ---

M.highlights = {
  -- Always disable background color
  Normal = { bg = "NONE" },

  Comment = { ui = "NONE" },
  NonText = { bg = "NONE", fg = "#2a2a2a", ui = "nocombine" },
  Question = { bg = "NONE" },
  CursorLine = { link = "LineNr", fg = "NONE" },
  CursorLineNr = { link = "Number" },
  Directory = { bg = "NONE" },
  VertSplit = { bg = "NONE" },
  FloatBorder = { bg = "NONE" },

  Todo = { clear = true },
  TroubleIndent = { clear = true },

  SignColumn = { bg = "NONE" },
  WhichKeyFloat = { link = "StatusLineNC" },

  QuickFixLine = { link = "Visual" },

  -- DAP Debugging
  DebugBreakpoint = { fg = "#ff0000", bg = "NONE" },
}

--- Utilities ---

--@param  group  : string = 'DiffAdd'
--@param  colors : table  = {'fg', 'gui'}
--@return color  : string = '#10e010'
function M.getHighlight(group, term)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), unpack(term))
end

function M.getHighlightTable(group)
  local output = fn.execute("hi " .. group)
  local list = fn.split(output, "\\s\\+")

  local dict = {}
  for _, item in pairs(list) do
    if fn.match(item, "=") > 0 then
      local splited = fn.split(item, "=")
      dict[splited[1]] = splited[2]
    end
  end
  return dict
end

--@param group  : string = 'DiffAdd'
--@param colors : table  = {fg = '#10e010'}
function M.setHighlight(group, colors)
  local bg = colors.bg and "guibg=" .. colors.bg or ""
  local fg = colors.fg and "guifg=" .. colors.fg or ""
  local sp = colors.sp and "guisp=" .. colors.sp or ""
  local ui = colors.ui and "gui=" .. colors.ui or ""

  local hl = "silent highlight " .. table.concat({ group, bg, fg, sp, ui }, " ")

  if colors.clear == true then
    vim.cmd("highlight clear " .. group)
    return
  end
  if colors.link then
    link = table.concat({ "link", group, colors.link }, " ")
    vim.cmd("highlight! " .. link)
  end
  vim.cmd(hl)
end

-- @param opts : { group = { fg = 'red', bg = 'blue' } }
function M.applyHighlights(opts)
  local next = next
  opts = type(opts) == "function" and opts() or opts
  for group, colors in pairs(opts) do
    if next(colors) ~= nil then
      M.setHighlight(group, colors)
    end
  end
end

--- Initialization ---

function M.setup()
  local name = g.colors_name

  -- Safety check for theme highlight table
  local ok, theme = pcall(require, "colors." .. name)
  if ok and theme.highlights then
    M.applyHighlights(theme.highlights)
  end

  -- Apply global overrides
  M.applyHighlights(M.highlights)
end

-- Update Colorscheme
-- Reload this function when colorscheme is updated
-- Run setup function when sourced / required

M.setup()

vim.cmd([[
augroup colorscheme_au
  autocmd!
  autocmd ColorScheme *
    \ lua require('colors').setup()
augroup END
]])

return M
