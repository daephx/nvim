-- Diffview.nvim | tabpage interface for easily cycling through diffs
-- https://github.com/sindrets/diffview.nvim

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  opts = function()
    local callback = require("diffview.config").diffview_callback
    return {
      -- Show diffs for binaries
      diff_binaries = false,
      -- See ':h diffview-config-enhanced_diff_hl'
      enhanced_diff_hl = false,
      -- Requires nvim-web-devicons
      use_icons = true,
      -- Only applies when use_icons is true.
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
      },
      file_panel = {
        win_config = {
          -- One of 'left', 'right', 'top', 'bottom'
          position = "right",
          -- Only applies when position is 'left' or 'right'
          width = 35,
          -- Only applies when position is 'top' or 'bottom'
          height = 10,
        },
        -- One of 'list' or 'tree'
        listing_style = "tree",
        -- Only applies when listing_style is 'tree'
        tree_options = {
          flatten_dirs = true,
          -- One of 'never', 'only_folded' or 'always'.
          folder_statuses = "always",
        },
      },
      file_history_panel = {
        win_config = {
          position = "bottom",
          width = 35,
          height = 16,
        },
        single_file = {
          max_count = 512,
          follow = true,
        },
        multi_file = {
          max_count = 128,
        },
      },
      key_bindings = {
        -- Disable the default key bindings
        disable_defaults = false,
        view = {
          -- Open the diff for the next file
          ["<tab>"] = callback("select_next_entry"),
          -- Open the diff for the previous file
          ["<s-tab>"] = callback("select_prev_entry"),
          -- Open the file in a new split in previous tabpage
          ["gf"] = callback("goto_file"),
          -- Open the file in a new split
          ["<C-w><C-f>"] = callback("goto_file_split"),
          -- Open the file in a new tabpage
          ["<C-w>gf"] = callback("goto_file_tab"),
          -- Bring focus to the files panel
          ["<leader>e"] = callback("focus_files"),
          -- Toggle the files panel.
          ["<leader>b"] = callback("toggle_files"),
        },
        file_panel = {
          -- Bring the cursor to the next file entry
          ["j"] = callback("next_entry"),
          ["<down>"] = callback("next_entry"),
          -- Bring the cursor to the previous file entry.
          ["k"] = callback("prev_entry"),
          ["<up>"] = callback("prev_entry"),
          -- Open the diff for the selected entry.
          ["<cr>"] = callback("select_entry"),
          ["o"] = callback("select_entry"),
          ["<2-LeftMouse>"] = callback("select_entry"),
          -- Stage / unstage the selected entry.
          ["-"] = callback("toggle_stage_entry"),
          -- Stage all entries.
          ["S"] = callback("stage_all"),
          -- Unstage all entries.
          ["U"] = callback("unstage_all"),
          -- Restore entry to the state on the left side.
          ["X"] = callback("restore_entry"),
          -- Update stats and entries in the file list.
          ["R"] = callback("refresh_files"),
          ["<tab>"] = callback("select_next_entry"),
          ["<s-tab>"] = callback("select_prev_entry"),
          ["gf"] = callback("goto_file"),
          ["<C-w><C-f>"] = callback("goto_file_split"),
          ["<C-w>gf"] = callback("goto_file_tab"),
          -- Toggle between 'list' and 'tree' views
          ["i"] = callback("listing_style"),
          -- Flatten empty subdirectories in tree listing style.
          ["f"] = callback("toggle_flatten_dirs"),
          ["<leader>e"] = callback("focus_files"),
          ["<leader>b"] = callback("toggle_files"),
        },
        file_history_panel = {
          -- Open the option panel
          ["g!"] = callback("options"),
          -- Open the entry under the cursor in a diffview
          ["<C-d>"] = callback("open_in_diffview"),
          ["zR"] = callback("open_all_folds"),
          ["zM"] = callback("close_all_folds"),
          ["j"] = callback("next_entry"),
          ["<down>"] = callback("next_entry"),
          ["k"] = callback("prev_entry"),
          ["<up>"] = callback("prev_entry"),
          ["<cr>"] = callback("select_entry"),
          ["o"] = callback("select_entry"),
          ["<2-LeftMouse>"] = callback("select_entry"),
          ["<tab>"] = callback("select_next_entry"),
          ["<s-tab>"] = callback("select_prev_entry"),
          ["gf"] = callback("goto_file"),
          ["<C-w><C-f>"] = callback("goto_file_split"),
          ["<C-w>gf"] = callback("goto_file_tab"),
          ["<leader>e"] = callback("focus_files"),
          ["<leader>b"] = callback("toggle_files"),
          -- Copy the commit hash of the entry under the cursor
          ["y"] = callback("copy_hash"),
        },
        option_panel = {
          ["<tab>"] = callback("select"),
          ["q"] = callback("close"),
        },
      },
    }
  end,
}
