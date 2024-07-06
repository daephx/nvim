-- Dashboard.nvim | vim dashboard
-- https://github.com/glepnir/dashboard-nvim

---@type LazyPluginSpec
return {
  "glepnir/dashboard-nvim",
  event = "UIEnter",
  dependencies = {
    -- Adds file type icons to Vim plugins
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = {
    theme = "doom",
    hide = {
      statusline = false,
      tabline = false,
      winbar = true,
    },
    config = {
      header = {
        "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
        "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
        "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
        "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
        "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
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
          icon = "",
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
          icon = "",
          desc = "Exit",
          keymap = "SHFT z z",
          key = "q",
          action = "exit",
        },
      },
      footer = function()
        local stats = require("lazy").stats()
        local startuptime = ("%.2f"):format(stats.startuptime):gsub("%.?0+$", "")
        local message = "Neovim loaded %s/%s plugins in %sms"
        return { "", "", message:format(stats.loaded, stats.count, startuptime) }
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Apply local settings to Dashboard buffer",
      group = vim.api.nvim_create_augroup("Dashboard_ftplugin", {}),
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
  config = function(_, opts)
    -- Add version information as sub header
    local v = vim.version()
    local release = v.prerelease == false and "stable" or "nightly"
    local template = "--- [   %s.%s.%s %s   ] ---"
    vim.list_extend(
      opts.config.header,
      { "", template:format(v.major, v.minor, v.patch, release), "", "" }
    )

    -- Add padding to the top of the header
    local toppad = 3
    for _ = 1, toppad do
      table.insert(opts.config.header, 1, "")
    end

    -- Add padding to dashboard entries
    for _, item in pairs(opts.config.center) do
      local pad = (" "):rep(math.abs(#item.desc - 19))
      item.icon = item.icon .. " "
      item.desc = item.desc .. pad
    end

    -- Load plugin and initialize options
    require("dashboard").setup(opts)
  end,
}
