-- colorizer.nvim | The fastest Neovim colorizer.
-- https://github.com/NvChad/nvim-colorizer.lua
local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then
  return
end

colorizer.setup({
  filetypes = {
    "*",
    "!lazy",
    "!mason",
    "!packer",
    "!popup",
    "!prompt",
  },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    mode = "background", -- Set the display mode.
  },
})
