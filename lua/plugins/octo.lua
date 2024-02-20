-- Octo.nvim | Edit and review GitHub issues and pull requests within neovim
-- https://github.com/pwntester/octo.nvim

return {
  "pwntester/octo.nvim",
  cmd = { "Octo" },
  config = true,
  dependencies = {
    -- Collection of useful lua functions
    { "nvim-lua/plenary.nvim" },
    -- Find, Filter, Preview, Pick. All lua, all the time.
    { "nvim-telescope/telescope.nvim" },
    -- Adds file type icons to Vim plugins
    { "nvim-tree/nvim-web-devicons" },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      desc = "Set buffer options for filetype octo",
      pattern = { "octo" },
      group = vim.api.nvim_create_augroup("OctoOptions", {}),
      callback = function()
        vim.opt_local.bufhidden = "delete"
        vim.opt_local.colorcolumn = "0"
        vim.opt_local.modifiable = false
        vim.opt_local.wrap = false
      end,
    })
  end,
}
