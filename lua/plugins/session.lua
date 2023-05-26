-- auto-session | A small automated session manager for Neovim
-- https://github.com/rmagatti/auto-session

local cmd_wrapper = function(cmd)
  return function()
    local action = (cmd):gsub("Session", "")
    local cwd = vim.fn.getcwd()
    vim.notify(("%s session: %s"):format(action, cwd), 2, {})
    vim.cmd(cmd)
  end
end

local delete_session = cmd_wrapper("SessionDelete")
local save_session = cmd_wrapper("SessionSave")

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
    { "<leader>sd", delete_session, desc = "Delete current session" },
    { "<leader>ss", save_session, desc = "Save current session" },
    { "<leader>sl", "<cmd>Telescope session-lens search_session<CR>", desc = "Show Session list" },
  },
  opts = {
    log_level = "error",
    auto_restore_enabled = true,
    auto_save_enabled = true,
    auto_session_suppress_dirs = { "/", "~/", "~/Documents", "~/Downloads", "~/Projects" },
    bypass_session_save_file_types = { "dashboard" },
    session_lens = { load_on_setup = false },
  },
}
