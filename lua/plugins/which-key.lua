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
  mode = { "n", "v" },
  ["["] = { name = "+Prev" },
  ["]"] = { name = "+Next" },
  ["g"] = { name = "+Goto" },
  ["g'"] = { name = "+Marks" },
  ["g`"] = { name = "+Marks" },
  ["gc"] = { name = "+Comment" },
  ["<leader>b"] = { name = "+Buffer" },
  ["<leader>d"] = { name = "+Debug" },
  ["<leader>f"] = { name = "+Fuzzy" },
  ["<leader>g"] = { name = "+Git" },
  ["<leader>p"] = { name = "+Plugins" },
  ["<leader>P"] = { name = "+Projects" },
  ["<leader>s"] = { name = "+Sessions" },
  ["<leader>t"] = { name = "+Terminal" },
  ["<leader>z"] = { name = "+Notes" },
})
