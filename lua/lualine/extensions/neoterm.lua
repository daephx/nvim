-- Lualine Extension: neoterm

local M = {}

M.sections = {
  lualine_a = { "mode" },
  lualine_z = { "filetype" },
}

M.filetypes = { "neoterm" }

return M
