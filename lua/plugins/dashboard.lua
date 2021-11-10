local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

g.dashboard_disable_at_vimenter = 0
g.dashboard_disable_statusline = 0
g.dashboard_default_executive = 'telescope'
g.dashboard_session_directory = fn.stdpath('cache') .. '/sessions'

-- Read text files from path 'nvim/static/*.txt'
-- use the filename for your ascii artwork for 'fname'
g.dashboard_custom_header = (function()
  local fname = 'super_meatboy'
  local spath = fn.stdpath('config') .. '/static/'
  return require('utils').fileToArray(spath..fname..'.txt')
end)()

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
