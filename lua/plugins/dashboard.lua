local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

-- Load utils module
local utils = require('utils')

-- Set header theme from static directory
-- Files are located in the 'nvim/static/' directory
-- Set your ascii artwork as a '.txt' file and call it by name!
local headerTheme = 'super_meatboy'
local _static = fn.stdpath('config') .. '/static/'
g.dashboard_custom_header = utils.fileToArray(_static..headerTheme..'.txt')

-- Define quick command section
g.dashboard_custom_section = {
  a = {description = {"  Find File             leader f f"}, command = "Files"},
  b = {description = {"  Recents               leader f h"}, command = "History"},
  c = {description = {"  Find Word             leader f g"}, command = "Telescope live_grep"},
  d = {description = {"  New File              leader e n"}, command = "DashboardNewFile"},
  e = {description = {"  Bookmarks             leader m  "}, command = "Marks"},
  f = {description = {"  Load Last Session     leader l  "}, command = "SessionLoad"},
  g = {description = {"  Update Plugins        leader u  "}, command = "PlugUpdate"},
  h = {description = {"  Settings              leader v e"}, command = "edit $MYVIMRC"},
  i = {description = {"  Exit                  leader q  "}, command = "exit"}
}

g.dashboard_custom_footer = {'type  :help<Enter>  or  <F1>  for on-line help'}

-- g.dashboard_session_directory = '~/.config/nvim/.sessions'
g.dashboard_session_directory = os.getenv("MYRUNTIME") .. "/sessions"
g.dashboard_default_executive = 'fzf'

vim.cmd[[
augroup dashboard_au
  autocmd! * <buffer>
  autocmd User dashboardReady let &l:stl = 'Dashboard'
  autocmd User dashboardReady highlight DashboardHeader guifg=#569cd6
  autocmd User dashboardReady setlocal fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

  autocmd User dashboardReady nnoremap <buffer> <leader>q <cmd>exit<CR>
  autocmd User dashboardReady nnoremap <buffer> <leader>u <cmd>PackerUpdate<CR>
  autocmd User dashboardReady nnoremap <buffer> <leader>l <cmd>SessionLoad<CR>

  autocmd User dashboardReady setlocal scrolloff=999
  autocmd FileType dashboard autocmd BufLeave <buffer> setlocal scrolloff=0
  autocmd User dashboardReady setlocal mouse=
  autocmd FileType dashboard autocmd BufLeave <buffer> set mouse=a

augroup END
]]



-- Disable statusline - But, I like the line!
-- vim.g.dashboard_disable_statusline = 1

-- HACK(daephx): Fix bug where statusline reappears
-- https://github.com/glepnir/dashboard-nvim/issues/87
-- vim.cmd[[autocmd Filetype dashboard set laststatus=0]]
-- NOTE: this doesn't seem to work...

-- Disable mouse on dashboard
-- Works when mouse is disabled on it's own,
-- but now when using an autocmd
-- https://github.com/glepnir/dashboard-nvim/issues/95
-- vim.cmd[[autocmd FileType dashboard set mouse=]]
-- NOTE: this also doesn't work...
