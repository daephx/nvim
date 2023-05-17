-- lua/plugins/session.lua

return {
  "rmagatti/session-lens",
  lazy = false,
  dependencies = {
    {
      "rmagatti/auto-session",
      opts = {
        log_level = "info",
        auto_restore_enabled = true,
        auto_save_enabled = true,
        bypass_session_save_file_types = false,
        auto_session_suppress_dirs = {
          "/",
          "~/",
          "~/Documents",
          "~/Downloads",
          "~/Projects",
        },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("telescope").load_extension("session-lens")
      end,
    },
  },
  opts = function()
    local themes = require("telescope.themes")
    return {
      prompt_title = "Sessions",
      previewer = false,
      theme_conf = {
        theme = themes.get_ivy(),
        border = true,
      },
    }
  end,
  config = function(_, opts)
    require("session-lens").setup(opts)

    vim.keymap.set("n", "<leader>sf", function()
      require("session-lens").search_session()
    end, { desc = "Show Session list" })

    vim.keymap.set("n", "<leader>sd", "<cmd>SessionDelete<CR>", { desc = "Delete current session" })
    vim.keymap.set(
      "n",
      "<leader>sl",
      "<cmd>Telescope session-lens search_session<CR>",
      { desc = "Load last session" }
    )
    vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save current session" })
  end,
}
