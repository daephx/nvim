-- Dashboard.nvim | vim dashboard
-- https://github.com/glepnir/dashboard-nvim
local db_ok, db = pcall(require, 'dashboard')
if not db_ok then
  return
end

-- db.preview_file_Path   = 'static/super_meatboy.txt'
-- db.preview_file_height = 15
-- db.preview_file_width  = 31
-- db.preview_command     = 'cat'
db.hide_statusline = false
db.hide_tabline = false

local default_header = {
  '',
  '',
  '███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  '████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  '██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  '██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  '██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  '╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  '',
  string.format(
    '               [   %s.%s.%s %s   ]                ',
    vim.version().major,
    vim.version().minor,
    vim.version().patch,
    vim.version().prerelease == true and 'nightly' or 'stable'
  ),
  '',
}

db.custom_header = default_header

local pad = function(str, count)
  local padding = string.rep(' ', math.abs(#str - count))
  return string.format('%s%s', str, padding)
end

local pad_icon = 4
local pad_desc = 22

-- Define quick command section
db.custom_center = {
  {
    icon = pad('', pad_icon),
    desc = pad('New File', pad_desc),
    shortcut = 'SPC e n',
    action = 'DashboardNewFile',
  },
  {
    icon = pad('', pad_icon),
    desc = pad('Recents', pad_desc),
    shortcut = 'SPC f r',
    action = 'Telescope oldfiles',
  },
  {
    icon = pad('', pad_icon),
    desc = pad('Bookmarks', pad_desc),
    shortcut = 'SPC f m',
    action = 'Telescope marks',
  },
  {
    icon = pad('', pad_icon),
    desc = pad('Find File', pad_desc),
    shortcut = 'SPC f f',
    action = 'Telescope find_files',
  },
  {
    icon = pad('', pad_icon),
    desc = pad('Find Word', pad_desc),
    shortcut = 'SPC f q',
    action = 'Telescope live_grep',
  },
  {
    icon = pad('', pad_icon),
    desc = pad('Load Last Session', pad_desc),
    shortcut = 'SPC s l',
    action = 'Telescope session-lens',
  },
  {
    icon = pad('', pad_icon),
    desc = pad('Update Plugins', pad_desc),
    shortcut = 'SPC p u',
    action = 'PackerUpdate',
  },
  {
    icon = pad('', pad_icon),
    desc = pad('Settings', pad_desc),
    shortcut = 'SPC f v',
    action = 'lua require("plugins.telescope").search_vimfiles()',
  },
  {
    icon = pad('', pad_icon),
    desc = pad('Exit', pad_desc),
    shortcut = 'SPC q q',
    action = 'exit',
  },
}

db.custom_footer = function()
  local plugin_path = vim.fn.stdpath('data') .. '/site/pack/packer/start'
  local plugin_files = vim.fn.globpath(plugin_path, '*', 0, 1)
  local plugin_count = vim.fn.len(plugin_files)
  return { '', string.format('Started with %s detected plugins', plugin_count) }
end

vim.cmd([[
augroup dashboard_au
  autocmd! * <buffer>

  " Set statusline for dashboard
  autocmd User dashboardReady let &l:stl = 'Dashboard'

  " Set dashboard header color
  autocmd User dashboardReady highlight DashboardHeader guifg=#569cd6

  " Disable mouse on dashboard
  autocmd User dashboardReady autocmd FileType dashboard setlocal mouse=

  " Disable fill characters on dashboard
  autocmd FileType dashboard setlocal fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

  " Disable Page scrolling keys on dashboard
  autocmd FileType dashboard nnoremap <buffer> <PageUp>   <Nop>
  autocmd FileType dashboard nnoremap <buffer> <PageDown> <Nop>

augroup END
]])
