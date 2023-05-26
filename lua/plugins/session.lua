-- auto-session | A small automated session manager for Neovim
-- https://github.com/rmagatti/auto-session

return {
  "rmagatti/auto-session",
  event = "VimEnter",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("telescope").load_extension("session-lens")
      end,
    },
  },
  keys = {
    { "<leader>sd", "<cmd>SessionDelete<CR>", desc = "Delete current session" },
    { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save current session" },
    { "<leader>sl", "<cmd>Telescope session-lens search_session<CR>", desc = "Show Session list" },
  },
  opts = {
    log_level = "info",
    auto_restore_enabled = true,
    auto_save_enabled = true,
    auto_session_suppress_dirs = { "/", "~/", "~/Documents", "~/Downloads", "~/Projects" },
    bypass_session_save_file_types = { "dashboard" },
    session_lens = { load_on_setup = false },
  },
}
