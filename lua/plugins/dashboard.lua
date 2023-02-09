-- Dashboard.nvim | vim dashboard
-- https://github.com/glepnir/dashboard-nvim
local db_ok, db = pcall(require, "dashboard")
if not db_ok then
  return
end

-- Dashboard whitespace padding helper
local fill_str = function(w)
  return function(str)
    local fill = (" "):rep(math.abs(#str - w))
    return ("%s%s"):format(str, fill)
  end
end

-- Define callback interfaces
local icon = fill_str(2)
local desc = fill_str(18)
local keymap = fill_str(7)

--- Setup ---

db.setup({
  theme = "doom",
  hide = {
    statusline = false,
    tabline = false,
    winbar = true,
  },
  config = {
    header = {
      "",
      "",
      "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
      "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
      "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
      "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
      "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
      "",
      string.format(
        "--- [   %s.%s.%s%s   ] ---",
        vim.version().major,
        vim.version().minor,
        vim.version().patch,
        vim.version().prerelease == true and "-dev" or ""
      ),
      "",
    },
    center = {
      {
        icon = icon(""),
        desc = desc("Find Files"),
        keymap = keymap("SPC f f"),
        key = "f",
        action = "Telescope find_files",
      },
      {
        icon = icon(""),
        desc = desc("Recent Files"),
        keymap = keymap("SPC f r"),
        key = "r",
        action = "Telescope oldfiles",
      },
      {
        icon = icon(""),
        desc = desc("Projects"),
        keymap = keymap("SPC f p"),
        key = "P",
        action = "Telescope projects",
      },
      {
        icon = icon(""),
        desc = desc("Applications"),
        keymap = keymap(""),
        key = "a",
        action = "Mason",
      },
      {
        icon = icon(""),
        desc = desc("Update Plugins"),
        keymap = keymap("SPC p u"),
        key = "p",
        action = "Lazy update",
      },
      {
        icon = icon(""),
        desc = desc("Settings"),
        keymap = keymap("SPC f v"),
        key = "s",
        action = 'lua require("plugins.telescope").search_vimfiles()',
      },
      {
        icon = icon(""),
        desc = desc("Exit"),
        keymap = keymap(""),
        key = "q",
        action = "exit",
      },
    },
    footer = function()
      local plugin_path = vim.fn.stdpath("data") .. "/lazy/"
      local plugin_files = vim.fn.globpath(plugin_path, "*", 0, 1)
      local plugin_count = vim.fn.len(plugin_files)
      return { "", "", string.format("Started with %s detected plugins!", plugin_count) }
    end,
  },
})

--- Autocmds ---

vim.api.nvim_create_augroup("Dashboard", {})
vim.api.nvim_create_autocmd("FileType", {
  desc = "Apply local settings to Dashboard buffer",
  pattern = "dashboard",
  callback = function(opts)
    vim.opt_local.fillchars = { eob = " " }
    -- Apply keymap settings for dashboard
    local options = { buffer = opts.buf, remap = false, silent = true }
    vim.keymap.set("n", "<PageDown>", "<Nop>", options)
    vim.keymap.set("n", "<PageUp>", "<Nop>", options)
  end,
})
