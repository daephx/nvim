-- auto-session | A small automated session manager for Neovim
-- https://github.com/rmagatti/auto-session

---@type LazySpec
return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>sd", "<cmd>AutoSession delete<CR>", desc = "Delete current session" },
    { "<leader>ss", "<cmd>AutoSession save<CR>", desc = "Save current session" },
    { "<leader>sl", "<cmd>Telescope session-lens search_session<CR>", desc = "Show Session list" },
  },
  opts = {
    log_level = "error",
    auto_restore_enabled = true,
    auto_save_enabled = true,
    auto_session_suppress_dirs = { "/", "~/", "~/Documents", "~/Downloads", "~/Projects" },
    bypass_session_save_file_types = { "dashboard", "oil" },
    session_lens = { load_on_setup = false },
  },
}
