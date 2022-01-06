-- Global colors | Override colorscheme settings

local M = {}

function M.highlights()
  return {
    -- Always disable background color
    Normal = { bg = 'NONE' },

    Comment = { ui = 'NONE' },
    NonText = { bg = 'NONE', fg = '#2a2a2a', ui = 'nocombine' },
    Question = { bg = 'NONE' },
    CursorLine = { link = 'LineNr', fg = 'NONE' },
    CursorLineNr = { link = 'Number' },
    Directory = { bg = 'NONE' },
    VertSplit = { bg = 'NONE' },
    FloatBorder = { bg = 'NONE' },

    Todo = { clear = true },
    TroubleIndent = { clear = true },

    SignColumn = { bg = 'NONE' },
    WhichKeyFloat = { link = 'StatusLineNC' },

    QuickFixLine = { link = 'Visual' },

    -- DAP Debugging
    DebugBreakpoint = { fg = '#ff0000', bg = 'NONE' },
  }
end

return M
