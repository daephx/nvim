-- nvim-autopairs | autopairs for neovim written by lua
-- https://github.com/windwp/nvim-autopairs
local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
if not autopairs_ok then
  return
end

autopairs.setup({})
