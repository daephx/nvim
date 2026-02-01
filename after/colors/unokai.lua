-- Define colors for builtin colorscheme: unokai
local M = {}

M.palette = {
  dark = "#282923",
  yellow = "#e6db74",
  gray = "#585546",
  dark_gray = "#666251",
  blue = "#51aebe",
  light_blue = "#66d9ef",
  separator = "#74705d",
  red = "#c61e5c",
  green = "#81af24",
  cyan = "#a1efe4",
  bright_green = "#a6e22e",
  orange = "#fd971f",
  pink = "#ec719e",
  violet = "#ae81ff",
}

M.palette.ui = {
  cursor = "#26251e",
  folded = "#3c3930",
  incsearch = "#ffaf5f",
  pmenukind = "#80beb5",
  visual = "#273b38",
  normal_fg = "#b0bec5",
}

M.palette.terminal = {
  "#000000",
  "#DC6068",
  "#ABCF76",
  "#E6B455",
  "#6E98EB",
  "#B480D6",
  "#71C6E7",
  "#EEFFFF",
  "#474747",
  "#F07178",
  "#C3E88D",
  "#FFCB6B",
  "#82AAFF",
  "#C792EA",
  "#89DDFF",
  "#EEFFFF",
}

M.palette.diff = {
  add = "#222f09",
  change = "#1a383d",
  delete = "#2c0614",
  text = "#253735",
}

M.palette.git = {
  added = M.palette.green,
  changed = M.palette.blue,
  removed = M.palette.red,
}

---@type config.Highlights
M.highlights = {
  ColorColumn = { ctermbg = 235, bg = M.palette.dark },
  CursorLine = { ctermbg = 237, bg = M.palette.ui.cursor },
  CursorLineNr = { ctermfg = 213, fg = M.palette.yellow, bold = true },
  EndOfBuffer = { link = "LineNr" },
  Folded = { ctermfg = 250, ctermbg = 235, fg = M.palette.yellow, bg = M.palette.ui.folded },
  IncSearch = { ctermfg = 215, ctermbg = 235, bg = M.palette.ui.incsearch, fg = M.palette.dark },
  LineNr = { ctermfg = 245, fg = M.palette.gray },
  LineNrAbove = { link = "LineNr" },
  LineNrBelow = { link = "LineNr" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { ctermfg = 245, fg = M.palette.dark_gray },
  Normal = { fg = M.palette.ui.normal_fg, bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { link = "Normal" },
  PmenuKind = { ctermfg = 73, fg = M.palette.ui.pmenukind },
  PmenuSel = { link = "Visual" },
  StatusLine = { link = "Normal" },
  StatusLineNC = { ctermfg = 235, ctermbg = 244, fg = M.palette.dark, bg = M.palette.ui.folded },
  TabLineFill = { link = "Normal" },
  Title = { link = "Define" },
  Underlined = { ctermfg = 81, fg = M.palette.blue, underline = true },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermfg = 116, ctermbg = 235, bg = M.palette.ui.visual },
  WinSeparator = { ctermfg = 244, fg = M.palette.separator },

  -- Diagnostics
  DiagnosticError = { link = "Error" },
  DiagnosticHint = { ctermfg = 81, fg = M.palette.blue },
  DiagnosticOk = { ctermfg = 106, fg = M.palette.green },
  Error = { ctermfg = 161, fg = M.palette.red },
  ErrorMsg = { link = "Error" },
  NvimInternalError = { link = "Error" },

  -- Git
  Added = { ctermfg = 106, fg = M.palette.git.added },
  Changed = { ctermfg = 81, fg = M.palette.git.changed },
  Removed = { ctermfg = 161, fg = M.palette.git.removed },

  -- Diff
  DiffAdd = { ctermbg = 65, bg = M.palette.diff.add },
  DiffChange = { ctermbg = 59, bg = M.palette.diff.change },
  DiffDelete = { ctermfg = 161, ctermbg = 234, fg = M.palette.red, bg = M.palette.diff.delete },
  DiffText = { ctermbg = 66, bg = M.palette.diff.text },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { ctermfg = 81, fg = M.palette.light_blue, nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 158, fg = M.palette.cyan, nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 148, fg = M.palette.bright_green, nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 208, fg = M.palette.orange, nocombine = true },
  RainbowDelimiterPink = { ctermfg = 205, fg = M.palette.pink, nocombine = true },
  RainbowDelimiterRed = { ctermfg = 161, fg = M.palette.red, nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 141, fg = M.palette.violet, nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 186, fg = M.palette.yellow, nocombine = true },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 40, bg = M.palette.diff.add, fg = M.palette.git.added },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 75, bg = M.palette.diff.change },
  NeogitDiffDelete = { ctermbg = 52, ctermfg = 196, fg = M.palette.red, bg = M.palette.diff.delete },
  NeogitDiffText = { ctermfg = "none", ctermbg = 66, fg = "none", bg = M.palette.diff.text },
  NeogitActiveItem = { ctermbg = 235, ctermfg = 208, bg = M.palette.dark, fg = M.palette.orange },
  NeogitCommitViewDescription = { link = "Normal" },
  NeogitObjectId = { ctermfg = 139, fg = M.palette.pink },
}

---Apply highlights to the current buffer
---@param highlights config.HighlightsTbl
M.apply_highlights = function(highlights)
  for group, properties in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, properties)
  end
end

---Apply terminal colors
---@param terminal any
M.apply_terminal = function(terminal)
  for i = 0, 15 do
    vim.g["terminal_color_" .. i] = terminal[i]
  end
end

return M.highlights
