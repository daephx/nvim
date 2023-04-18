-- Which-key | Configurations for plugin WhichKey.nvim
-- https://github.com/folke/which-key.nvim
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
  return
end

wk.setup({
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  operators = { gc = "Comments" },
  key_labels = {
    ["<bs>"] = "BS",
    ["<cr>"] = "RET",
    ["<space>"] = "SPC",
    ["<tab>"] = "TAB",
  },
  window = {
    border = { "", "_", "", "", "", "", "", "" },
  },
})

wk.register({
  name = "+WhichKey",
  d = { name = "+Debug" },
  f = { name = "+Fuzzy" },
  g = { name = "+Git" },
  n = { name = "+New" },
  p = { name = "+Plugins" },
  s = { name = "+Session" },
  t = { name = "+Terminal" },
  z = { name = "+Notes" },
}, { prefix = "<Leader>" })
