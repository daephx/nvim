-- colorizer.nvim | The fastest Neovim colorizer.
-- https://github.com/NvChad/nvim-colorizer.lua

return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufRead", "BufWinEnter" },
  opts = {
    buftypes = {
      "*",
      "!nofile",
      "!popup",
      "!prompt",
    },
    filetypes = {
      "*",
      css = { css = true },
    },
    user_default_options = {
      RGB = false, -- #RGB hex codes
      names = false, -- "Name" codes like Blue
      mode = "background", -- Set the display mode.
    },
  },
}
