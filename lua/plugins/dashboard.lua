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
  a = {description = {'  New File              SPC e n'}, command = 'DashboardNewFile'},
  b = {description = {'  Recents               SPC f r'}, command = 'Telescope oldfiles'},
  c = {description = {'  Bookmarks             SPC f m'}, command = 'Telescope marks'},
  d = {description = {'  Find File             SPC f f'}, command = 'Telescope find_files'},
  e = {description = {'  Find Word             SPC f g'}, command = 'Telescope live_grep'},
  f = {description = {'  Load Last Session     SPC s l'}, command = 'SessionLoad'},
  g = {description = {'  Update Plugins        SPC p u'}, command = 'PackerUpdate'},
  h = {description = {'  Settings              SPC f v'}, command = 'lua require("plugins.telescope").search_vimfiles()'},
  i = {description = {'  Exit                  SPC q q'}, command = 'exit'},
}

local plugin_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
g.dashboard_custom_footer = {'Started with ' .. plugin_count .. ' detected plugins'}


cmd([[
augroup dashboard_au
  autocmd! * <buffer>

  " Set statusline for dashboard
  autocmd User dashboardReady let &l:stl = 'Dashboard'

  " Set dashboard header color
  autocmd User dashboardReady highlight DashboardHeader guifg=#569cd6

  " Disable fill characters on dashboard
  autocmd FileType dashboard setlocal fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

  " Set scroll offset for dashboard, restore previous on BufLeave
  autocmd FileType dashboard let prev_scrolloff = &scrolloff | setlocal scrolloff=999
  autocmd FileType dashboard autocmd BufLeave <buffer> let &scrolloff = prev_scrolloff

  " Disable mouse on dashboard
  autocmd User dashboardReady autocmd FileType dashboard setlocal mouse=
  " autocmd FileType dashboard let s:prev_mouse=&mouse | setlocal mouse=
  " autocmd FileType dashboard autocmd BufLeave <buffer> let &mouse = prev_mouse

  " Disable Page scrolling keys on dashboard
  autocmd FileType dashboard nnoremap <buffer> <PageUp>   <Nop>
  autocmd FileType dashboard nnoremap <buffer> <PageDown> <Nop>

  " Set Dashboard command remaps
  autocmd FileType dashboard nnoremap <buffer> <leader>qq <cmd>exit<CR>
  autocmd FileType dashboard nnoremap <buffer> <leader>sl <cmd>SessionLoad<CR>

" Reopen dashboard when closing last buffer
  autocmd BufDelete *
    \ if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1 && &ft != 'dashboard'
    \ | Dashboard
    \ | endif

augroup END
]])
