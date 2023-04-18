-- colorizer.nvim | The fastest Neovim colorizer.
-- https://github.com/NvChad/nvim-colorizer.lua
local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then
  return
end

colorizer.setup({
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
})
