-- Configuration for snacks.nvim scratch module (temporary scratch buffers)
-- Main configuration is in lua/plugins/snacks/init.lua
-- https://github.com/folke/snacks.nvim/blob/main/docs/scratch.md

---@type LazySpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  },
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    scratch = {
      enabled = true,
      win = {
        width = 0.7,
        height = 0.5,
        -- bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
        -- minimal = false,
        -- noautocmd = false,
        -- position = "right",
        -- zindex = 20,
        -- wo = { winhighlight = "NormalFloat:Normal" },
        -- footer_keys = true,
        -- border = true,
      },
    },
  },
}
