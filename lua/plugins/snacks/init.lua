-- snacks.nvim | A collection of QoL plugins for Neovim
-- https://github.com/folke/snacks.nvim

---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  import = "plugins.snacks",
  init = function()
    local colors = require("config.colors")
    colors.set_hl_autocmd(nil, {
      SnacksDashboardDesc = { link = "Special", default = true },
      SnacksDashboardFooter = { link = "SpecialChar", default = true },
      SnacksDashboardHeader = { link = "SpecialChar", default = true },
      SnacksDashboardIcon = { link = "Keyword", default = true },
      SnacksDashboardKey = { link = "Comment", default = true },
      SnacksDashboardShortCut = { link = "Keyword", default = true },
      SnacksPickerBorder = { link = "FloatBorder", default = true },
      SnacksPickerBoxTitle = { link = "Title", default = true },
      SnacksPickerDesc = { link = "Comment", default = true },
      SnacksPickerDir = { link = "NonText", default = true },
      SnacksPickerInputBorder = { link = "Special", default = true },
      SnacksPickerInputTitle = { link = "Title", default = true },
    })
    vim.api.nvim_create_autocmd("User", {
      desc = "Setup LSP-integrated file renaming for snacks.rename and oil.nvim",
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions[1].type == "move" then
          local src_url = event.data.actions[1].src_url
          local dest_url = event.data.actions[1].dest_url
          Snacks.rename.on_rename_file(src_url, dest_url)
        end
      end,
    })
    -- Hide end-of-buffer characters in dashboard
    vim.api.nvim_create_autocmd("User", {
      desc = "Disable EndOfBuffer fillchar on snacks.dashboard",
      pattern = "SnacksDashboardOpened",
      callback = function()
        vim.opt_local.fillchars = { eob = " " }
      end,
    })
  end,
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    quickfile = { enabled = false },
    rename = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    bigfile = {
      notify = true, -- show notification when big file detected
      size = 1.0 * 1024 * 1024, -- 1MB
    },
    input = {
      prompt_pos = "title",
      icon = "",
    },
    explorer = {
      enabled = false,
      replace_netrw = true,
      jump = { close = true },
    },
    notifier = {
      enabled = true,
      margin = { bottom = 1 },
      top_down = false, -- place notifications from top to bottom
      notification = {
        wrap = true, -- Wrap notification text
      },
    },
    image = {
      enabled = true,
      doc = { enabled = true },
    },
    styles = {
      -- This keeps the image on the top right corner, basically leaving your
      -- text area free, suggestion found in reddit by user `Redox_ahmii`
      snacks_image = {
        relative = "editor",
        col = -1,
      },
      new_name = {
        relative = "cursor",
        col = -3,
        row = -3,
      },
    },
  },
}
