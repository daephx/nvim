-- Dashboard.nvim | vim dashboard
-- https://github.com/glepnir/dashboard-nvim
local db_ok, db = pcall(require, "dashboard")
if not db_ok then
  return
end

db.hide_statusline = false
db.hide_tabline = false
db.custom_header = {
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
}

-- helpers for formatting dashboard commands
local pad_icon = 4
local pad_desc = 22
local padding = function(str, count)
  local whitespace = string.rep(" ", math.abs(#str - count))
  return string.format("%s%s", str, whitespace)
end

-- Define quick command section
db.custom_center = {
  {
    icon = padding("", pad_icon),
    desc = padding("New File", pad_desc),
    shortcut = "SPC e n",
    action = "DashboardNewFile",
  },
  {
    icon = padding("", pad_icon),
    desc = padding("Recents", pad_desc),
    shortcut = "SPC f r",
    action = "Telescope oldfiles",
  },
  {
    icon = padding("", pad_icon),
    desc = padding("Bookmarks", pad_desc),
    shortcut = "SPC f m",
    action = "Telescope marks",
  },
  {
    icon = padding("", pad_icon),
    desc = padding("Find File", pad_desc),
    shortcut = "SPC f f",
    action = "Telescope find_files",
  },
  {
    icon = padding("", pad_icon),
    desc = padding("Find Word", pad_desc),
    shortcut = "SPC f q",
    action = "Telescope live_grep",
  },
  {
    icon = padding("", pad_icon),
    desc = padding("Sessions", pad_desc),
    shortcut = "SPC s l",
    action = "Telescope session-lens search_session",
  },
  {
    icon = padding("", pad_icon),
    desc = padding("Update Plugins", pad_desc),
    shortcut = "SPC p u",
    action = "PackerSync",
  },
  {
    icon = padding("", pad_icon),
    desc = padding("Settings", pad_desc),
    shortcut = "SPC f v",
    action = 'lua require("plugins.telescope").search_vimfiles()',
  },
  {
    icon = padding("", pad_icon),
    desc = padding("Exit", pad_desc),
    shortcut = "SPC q q",
    action = "exit",
  },
}

db.custom_footer = function()
  local plugin_path = vim.fn.stdpath("data") .. "/site/pack/packer/start"
  local plugin_files = vim.fn.globpath(plugin_path, "*", 0, 1)
  local plugin_count = vim.fn.len(plugin_files)
  return { "", string.format("Started with %s detected plugins", plugin_count) }
end

--- Autocmds ---

vim.api.nvim_create_augroup("Dashboard", {})
vim.api.nvim_create_autocmd("FileType", {
  desc = "Apply local settings to Dashboard buffer",
  pattern = "dashboard",
  callback = function(opts)
    vim.opt_local.buflisted = false
    vim.opt_local.fillchars = { eob = " " }
    -- Apply keymap settings for dashboard
    local options = { buffer = opts.buf, remap = false, silent = true }
    vim.keymap.set("n", "<PageDown>", "<Nop>", options)
    vim.keymap.set("n", "<PageUp>", "<Nop>", options)
    vim.keymap.set("n", "<leader>qq", "<cmd>quit<cr>", options)
  end,
})
