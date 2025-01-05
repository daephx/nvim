-- Diffview.nvim | tabpage interface for easily cycling through diffs
-- https://github.com/sindrets/diffview.nvim
---@module "diffview"

-- Generate a configuration table for a floating window
---@return vim.api.keyset.win_config
local win_config = function()
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.4)
  return {
    type = "float",
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
  }
end

---@type LazySpec
return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewFileHistory",
    "DiffviewLog",
    "DiffviewOpen",
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "DiffView" },
  },
  opts = function()
    local actions = require("diffview.actions")
    local select_entry = function()
      actions.select_entry()
      actions.close()
    end
    return {
      file_panel = {
        listing_style = "list",
        win_config = win_config,
      },
      view = {
        merge_tool = {
          disable_diagnostics = true,
        },
      },
      keymaps = {
        view = {
          { "n", "gq", actions.close, { desc = "Close Diffview" } },
          { "n", "<leader>e", actions.toggle_files, { desc = "Diffview file panel" } },
        },
        file_panel = {
          { "n", "<cr>", select_entry, { desc = "Select entry" } },
          { "n", "<tab>", select_entry, { desc = "Select entry" } },
          { "n", "q", actions.close, { desc = "Close file panel" } },
          { "n", "<leader>e", actions.toggle_files, { desc = "Diffview file panel" } },
        },
        file_history_panel = {
          { "n", "gq", actions.close, { desc = "Close Diffview" } },
          { "n", "<leader>e", actions.toggle_files, { desc = "Diffview file panel" } },
        },
      },
      hooks = {
        view_opened = function()
          -- Close file panel when initially opening diffview tab
          actions.toggle_files()
        end,
      },
    }
  end,
  init = function()
    local colors = require("config.colors")
    colors.set_hl_autocmd(nil, {
      DiffviewStatusModified = { link = "Changed" },
    })
    vim.api.nvim_create_autocmd("WinLeave", {
      desc = "Close the Diffview file panel when switching focus back to the diff buffer",
      group = vim.api.nvim_create_augroup("Diffview#AutoCloseFilesPanel", { clear = true }),
      pattern = "diffview:///panels/*/DiffviewFilePanel",
      callback = function(ev)
        local winids = vim.fn.win_findbuf(ev.buf)
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
        if #winids > 0 and filetype == "DiffviewFiles" then
          vim.api.nvim_win_close(winids[1], false)
        end
      end,
    })
    vim.api.nvim_create_autocmd("VimLeavePre", {
      desc = "Close all Diffview tabs when exiting Vim to avoid saving them in sessions",
      group = vim.api.nvim_create_augroup("Diffview#AutoClose", { clear = true }),
      once = true,
      callback = function()
        for _, view in ipairs(require("diffview.lib").views) do
          view:close()
        end
      end,
    })
  end,
}
