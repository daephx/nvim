-- Dashboard.nvim | vim dashboard
-- https://github.com/glepnir/dashboard-nvim

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
        "",
      },
      center = {
        {
          icon = "",
          desc = "Find Files",
          keymap = "SPC f f",
          key = "f",
          action = "Telescope find_files",
        },
        {
          icon = "",
          desc = "Recent Files",
          keymap = "SPC f r",
          key = "r",
          action = "Telescope oldfiles",
        },
        {
          icon = "",
          desc = "Projects",
          keymap = "SPC f p",
          key = "P",
          action = "Telescope projects",
        },
        {
          icon = "󰆓",
          desc = "Applications",
          keymap = "SPC p m",
          key = "m",
          action = "Mason",
        },
        {
          icon = "",
          desc = "Plugins",
          keymap = "SPC p l",
          key = "p",
          action = "Lazy",
        },
        {
          icon = "",
          desc = "Settings",
          keymap = "SPC f v",
          key = "s",
          action = "Telescope vimfiles",
        },
        {
          icon = "󰅗",
          desc = "Exit",
          keymap = "",
          key = "q",
          action = "exit",
        },
      },
      footer = function()
        local plugins_total = require("lazy").stats().count ---@type integer
        local plugins_loaded = require("lazy").stats().loaded ---@type integer
        local startup_time = ("%.2f"):format(require("lazy").stats().startuptime)
        local message = "Neovim loaded %s/%s plugins in %sms"
        return { "", "", message:format(plugins_loaded, plugins_total, startup_time) }
      end,
    },
  },
  config = function(_, opts)
    require("dashboard").setup(opts)

    -- Add padding to dashboard entries
    for _, item in pairs(opts.config.center) do
      local pad = (" "):rep(math.abs(#item.desc - 19))
      item.icon = item.icon .. " "
      item.desc = item.desc .. pad
    end

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Apply local settings to Dashboard buffer",
      group = vim.api.nvim_create_augroup("DashboardBuffer", {}),
      pattern = "dashboard",
      callback = function(ev)
        vim.opt_local.fillchars = { eob = " " }
        -- Apply keymap settings for dashboard
        local options = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "<PageDown>", "<Nop>", options)
        vim.keymap.set("n", "<PageUp>", "<Nop>", options)
      end,
    })
  end,
}
