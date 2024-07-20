-- oil.nvim | Edit your filesystem like a buffer
-- https://github.com/stevearc/oil.nvim
---@module "oil"

---@type LazyPluginSpec
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Oil" },
  keys = {
    { "<leader>e", "<cmd>Oil --float .<CR>", desc = "Open file explorer" },
  },
  init = function()
    -- Set custom vim style explorer commands
    local create_command = vim.api.nvim_create_user_command
    create_command("Explore", "Oil <args>", { nargs = "?", complete = "dir" })
    create_command("Sexplore", "belowright split | Oil <args>", { nargs = "?", complete = "dir" })
    create_command("Vexplore", "rightbelow vsplit | Oil <args>", { nargs = "?", complete = "dir" })
    create_command("Texplore", "tabedit % | Oil <args>", { nargs = "?", complete = "dir" })
  end,
  opts = {
    default_file_exporer = true,
    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    -- Window-local options to use for oil buffers
    win_options = {
      number = false,
      relativenumber = false,
      concealcursor = "nvic",
      colorcolumn = "0",
      conceallevel = 3,
      cursorcolumn = false,
      foldcolumn = "0",
    },
    view_options = {
      show_hidden = true,
    },
    -- Configuration for the floating window in oil.open_float
    float = {
      max_width = 114,
      max_height = 32,
      border = vim.g.border,
    },
    -- Configuration for the actions floating preview window
    preview = {
      border = vim.g.border,
      width = 0.5,
    },
    -- Configuration for the floating progress window
    progress = {
      border = vim.g.border,
    },
    -- Configuration for the floating SSH window
    ssh = {
      border = vim.g.border,
    },
    -- Configuration for the floating keymaps help window
    keymaps_help = {
      border = vim.g.border,
    },
  },
}
