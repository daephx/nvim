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

  if g.loaded_indent_blankline then
    cmd [[ " Highlight all indentation lines
    " highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
    " highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
    " highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
    " highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
    " highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
    " highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
    ]]
  end

  -- Coc.vim diagnostic partial overrides
  cmd [[
  " This fixes background colors for diagnostic signs in the gutter
  " effective if you don't have the background colors disabled
  if !empty('g:coc_enabled')
    " CocWarningSign -- Refers to gutter
    " CocWarningVirtualText -- Links to gutter
    " The above need to be linked enough so that the sign fg colors
    " are perserved, but they should have diffrent bg colors

    " The gutter entry also should reference the LineNr guibg highlight
    " This could possible be set to 'NONE' but for some themes I leave it alone.

    for label in ['Hint', 'Info', 'Warn', 'Error']
      exec 'hi link ' . 'Coc' . label . 'Sign ' . 'DiagnosticSign' . label
      exec 'hi DiagnosticSign' . label .
      \' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
      \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
    endfor
  endif
  ]]
end

return M
