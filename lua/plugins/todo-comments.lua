-- Module: plugins.todo-comments
-- Description: configurations for plugin 'todo-comments'

local todo_comments = require('todo-comments')

todo_comments.setup({
  signs = true, -- show icons in the signs column
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = ' ', -- icon used for the sign, and in search results
      color = 'error', -- can be a hex color, or a named color (see below)
      alt = { 'FIXME', 'BUG', 'FIXIT', 'FIX', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = ' ', color = 'info' },
    HACK = { icon = ' ', color = 'warning' },
    WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
    PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
    NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
  },
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    before = '', -- "fg" or "bg" or empty
    keyword = 'fg', -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = '', -- "fg" or "bg" or empty
    -- pattern = [[.*<(KEYWORDS)\s*:]], -- pattern used for highlightng (vim regex)
    pattern = [[.*<(KEYWORDS)(\(.*\))?:]], -- pattern used for highlightng (vim regex)
    comments_only = true, -- this applies the pattern only inside comments using `commentstring` option
    exclude = { 'log', 'help' }, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of hilight groups or use the hex color if hl not found as a fallback
  colors = {
    default = { 'Identifier', '#7C3AED' },
    hint = { 'LspDiagnosticsDefaultHint', '#10B981' },
    info = { 'LspDiagnosticsDefaultInformation', '#2563EB' },
    warning = { 'LspDiagnosticsDefaultWarning', 'WarningMsg', '#FBBF24' },
    error = { 'LspDiagnosticsDefaultError', 'ErrorMsg', '#DC2626' },
  },
  search = {
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    pattern = [[\b(KEYWORDS)(\(.*\))?:]], -- Match to colon ':', optional parens | KEYWORD(AUTHOR):
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})

vim.cmd([[

  " Highlights

  " Builtin todo highlight
  highlight Todo guibg=none

  " Todo-comment overrides
  highlight TodoBgTODO guibg=none
  highlight TodoBgFIX guibg=none
  highlight TodoBgHACK guibg=none
  highlight TodoBgNOTE guibg=none
  highlight TodoBgPERF guibg=none
  highlight TodoBgWARN guibg=none

  " Alternativly link to diagnostics
  " highlight link TodoBgTODO DiagnosticsHint
  " highlight link TodoBgFIX DiagnosticsWarn
  " highlight link TodoBgHACK DiagnosticsError
  " highlight link TodoBgNOTE DiagnosticsInfo
  " highlight link TodoBgPERF DiagnosticsInfo
  " highlight link TodoBgWARN DiagnosticsWarn


  " Commands
  command! Todo TodoTrouble

]])
