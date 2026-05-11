-- Configuration for snacks.nvim dashboard module (startup screen)
-- Main configuration is in lua/plugins/snacks/init.lua
-- https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md

---Configure the dashboard header with version information
---Adds Neovim version and release type below the main header
---@param item snacks.dashboard.Item The dashboard item to modify
---@return snacks.dashboard.Text
local function format_dashboard_header(item)
  local v = vim.version()
  local release = v.prerelease == nil and "stable" or "nightly"
  local version = ("--- [   %s.%s.%s %s   ] ---"):format(v.major, v.minor, v.patch, release)
  local header = item.header .. "\n\n" .. version
  return { header, hl = "SnacksDashboardHeader" }
end

---Format dashboard key mappings for display
---Converts key mappings to a readable format with brackets and key hints
---@param item snacks.dashboard.Item The dashboard item to modify
---@return snacks.dashboard.Text
local function format_dashboard_key(item)
  local keymaps = {
    f = "SPC f f",
    r = "SPC f r",
    p = "SPC f p",
    m = "SPC p m",
    P = "SPC p l",
    s = "SPC s r",
    v = "SPC f v",
    q = "SHFT z z",
  }
  local hint = keymaps[item.key] and keymaps[item.key] .. " " or ""
  local key = "[" .. item.key .. "]"
  return {
    { hint, hl = "SnacksDashboardShortCut" },
    { key, hl = "SnacksDashboardKey" },
  }
end

-- Basic ASCII header
local header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

---@type LazySpec
return {
  "snacks.nvim",
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      width = 40,
      row = math.floor(vim.o.lines / 6),
      sections = {
        { section = "header", align = "center" },
        { section = "keys", gap = 1, padding = 3 },
        { section = "startup", padding = 0, gap = 0 },
      },
      formats = {
        header = format_dashboard_header,
        key = format_dashboard_key,
      },
      preset = {
        header = header,
        ---@type snacks.dashboard.Item[]
        keys = {
          {
            icon = " ",
            key = "f",
            desc = "Find Files",
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = " ",
            key = "p",
            desc = "Projects",
            action = ":lua Snacks.dashboard.pick('projects')",
          },
          { icon = " ", key = "m", desc = "Applications", action = ":Mason" },
          { icon = " ", key = "P", desc = "Plugins", action = ":Lazy" },
          {
            icon = " ",
            key = "s",
            desc = "Sessions",
            section = "session",
            action = "AutoSession search",
          },
          {
            icon = " ",
            key = "v",
            desc = "Settings",
            action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
          },
          { icon = " ", key = "q", desc = "Exit", action = ":quitall" },
        },
      },
    },
  },
}
