local cmd = vim.cmd


local M = {}

-- Remove background color / transparency
-- NOTE: Check if your colorscheme also has similar options
function M.TransparentBackground()
  cmd [[highlight Normal guibg=none]]
end


function M.PartialHighlightLink()

  -- Example in vimscript
  -- From: https://stackoverflow.com/a/18776976

  -- hi link SyntasticErrorLine SignColumn
  --
  -- exec 'hi SyntasticErrorSign guifg=red ctermfg=red' .
  --   \' guibg='   . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
  --   \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')

  -- GitSignsAdd
  -- GitSignsChange
  -- GitSignsDelete

  -- All should depend on colorscheme
  -- But the background/foreground need to be overwritten

end


-- HACK: Function not complete / in Functional state
local function DiffHighlights()
  local higroups = {
    {'GitSignsAdd', 'DiffAdd'},
    {'GitSignsChange', 'DiffChange'},
    {'GitSignsDelete', 'DiffDelete'}
  }
  for group in higroups do
    cmd('highlight clear ' .. x[1])
    cmd('highlight link  ' .. x[1] .. x[2])
  end
end


function M.GeneralOverrides()

  -- Vimscript overrides
  -- the lua support for highlight settings isn't great
  -- so global overrides for highlight groups are defined below.

  cmd [[
  " Disable italic comments
  highlight Comment gui=none

  " Remove background color from listchars
  highlight NonText guibg=none

  " Remove background color from question
  highlight Question guibg=none

  " Modify CursorLine
  highlight clear CursorLine
  highlight link CursorLine LineNr
  highlight CursorLine cterm=underline

  " Link CursorLine and CursorLineNr
  " This makes the number color background color
  " match the cursorline whererever the cursor is.
  " highlight clear CursorLine
  " highlight link CursorLine CursorLineNr

  " Set clearer foreground colors
  " highlight DiffAdd    guibg=none guifg=green
  " highlight DiffChange guibg=none guifg=yellow
  " highlight DiffDelete guibg=none guifg=red

  " Remove background from directory listings
  highlight Directory guibg=none

  " Floating Window disable Background
  highlight NormalFloat guibg=none
  " highlight FloatBoarder guibg=none

  " Gitsigns overrides
  " function! s:ExtractHighlight(id, grp, typ)
  "   return synIDattr(synIDtrans(hlID(a:id)), a:typ, a:grp)
  " endfunction

  " let s:color = s:ExtractHighlight('GitSignsAdd', 'gui', 'fg')
  " redraw | echom s:color

  " Override GitSign background color from SignColumn
  " This allows you to have your theme manage the sign/number Column
  " and keep those settings without converting it to black

  for highlightGroup in [
  \ 'GitSignsAdd',
  \ 'GitSignsChange',
  \ 'GitSignsDelete']
  exec 'hi '     . highlightGroup .
  \' guibg='   . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
  \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
  endfor

  " Coc.vim diagnostic overrides
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
