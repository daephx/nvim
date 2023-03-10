-- Copyright (c) 2020-2022 daephx
-- MIT license, see LICENSE for more details.

local M = {}

M.sections = {
  lualine_a = {
    {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    },
  },
  lualine_c = { "filename" },
  lualine_x = { "searchcount" },
  lualine_z = { "location" },
}

M.filetypes = {
  "floaterm",
  "neoterm",
  "terminal",
  "toggleterm",
}

return M
