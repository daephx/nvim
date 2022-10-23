-- nvim-autopairs | autopairs for neovim written by lua
-- https://github.com/windwp/nvim-autopairs
local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
if not autopairs_ok then
  return
end

-- Initialize plugin settings
autopairs.setup({
  check_ts = true,
  disable_filetype = { 'TelescopePrompt', 'vim' },
  fast_wrap = {},
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
  },
})
