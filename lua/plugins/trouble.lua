-- trouble.nvim | pretty diagnostics, references, telescope results
-- https://github.com/folke/trouble.nvim
---@module "trouble"

---@type LazyPluginSpec
return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  dependencies = {
    -- Lua fork of vim-web-devicons for neovim
    { "nvim-tree/nvim-web-devicons" },
  },
  -- stylua: ignore
  keys = {
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      desc = "Apply local options to Trouble buffer",
      group = vim.api.nvim_create_augroup("Trouble#Buffer", {}),
      pattern = "trouble",
      callback = function()
        vim.opt_local.colorcolumn = "0"
        vim.opt_local.cursorline = true
        vim.opt_local.cursorlineopt = "both"
        vim.opt_local.statuscolumn = "o"
      end,
    })
  end,
  ---@type trouble.Config
  opts = {
    auto_close = false, -- Auto close when there are no items
    focus = true, -- Focus the window when opened
    follow = false, -- Follow the current item
    win = {
      border = vim.g.border,
    },
  },
}
