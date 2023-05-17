-- Dashboard.nvim | vim dashboard
-- https://github.com/glepnir/dashboard-nvim

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

return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  dependices = { "nvim-tree/nvim-web-devicons" },
  opts = {
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
          keymap = keymap("SPC p m"),
          key = "m",
          action = "Mason",
        },
        {
          icon = icon(""),
          desc = desc("Plugins"),
          keymap = keymap("SPC p l"),
          key = "p",
          action = "Lazy",
        },
        {
          icon = icon(""),
          desc = desc("Settings"),
          keymap = keymap("SPC f v"),
          key = "s",
          action = "Telescope vimfiles",
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
        local lazy_ok, lazy = pcall(require, "lazy")
        local plugin_count = lazy_ok and lazy.stats().loaded or nil
        return { "", "", string.format("Started with %s loaded plugins!", plugin_count) }
      end,
    },
  },
  config = function(_, opts)
    require("dashboard").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Apply local settings to Dashboard buffer",
      group = vim.api.nvim_create_augroup("DashboardBuffer", {}),
      pattern = "dashboard",
      callback = function(ev)
        vim.opt_local.fillchars = { eob = " " }
        -- Apply keymap settings for dashboard
        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "<PageDown>", "<Nop>", opts)
        vim.keymap.set("n", "<PageUp>", "<Nop>", opts)
      end,
    })
  end,
}
