-- trouble.nvim | pretty diagnostics, references, telescope results
-- https://github.com/folke/trouble.nvim

---@type LazyPluginSpec
return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    padding = false, -- add an extra new line on top of the list
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = true, -- automatically close the list when you have no diagnostics
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
  },
  config = function(_, opts)
    require("trouble").setup(opts)

    --- Autocmds ---

    vim.api.nvim_create_augroup("TroubleBuffer", {})
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Apply local options to Trouble buffer",
      group = "TroubleBuffer",
      pattern = "Trouble",
      callback = function()
        vim.opt_local.cursorline = true
        vim.opt_local.cursorlineopt = "both"
        vim.opt_local.colorcolumn = "0"
      end,
    })
  end,
}
