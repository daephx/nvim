--     ____        _ ____  _
--    / __ )__  __(_) / /_(_)___  _____
--   / __  / / / / / / __/ / __ \/ ___/
--  / /_/ / /_/ / / / /_/ / / / (__  )
-- /_____/\__,_/_/_/\__/_/_/ /_/____/
-- ====================================
-- Manage builtin vim runtime plugins.
-- Disabling these can improve startuptime.

local builtins = {
  did_indent_on = 1,
  did_load_ftplugin = 1,
  loaded_2html_plugin = 1,
  loaded_bugreport = 1,
  loaded_compiler = 1,
  loaded_ftplugin = 1,
  loaded_getscript = 1,
  loaded_getscriptPlugin = 1,
  loaded_gzip = 1,
  loaded_logiPat = 1,
  loaded_matchit = 1,
  loaded_matchparen = 0,
  loaded_netrw = 0,
  loaded_netrwFileHandlers = 0,
  loaded_netrwPlugin = 0,
  loaded_netrwSettings = 0,
  loaded_node_provider = 1,
  loaded_optwin = 1,
  loaded_perl_provider = 1,
  loaded_python3_provider = 1,
  loaded_python_provider = 1,
  loaded_rplugin = 1,
  loaded_rrhelper = 1,
  loaded_ruby_provider = 1,
  loaded_spellfile_plugin = 0,
  loaded_synmenu = 1,
  loaded_syntax = 1,
  loaded_tar = 1,
  loaded_tarPlugin = 1,
  loaded_tutor = 1,
  loaded_vimball = 1,
  loaded_vimballPlugin = 1,
  loaded_zip = 1,
  loaded_zipPlugin = 1,
}

-- Set global variables
for k, v in pairs(builtins) do
  vim.g[k] = v
end

--- Settings ---

-- For the plugins that are still enabled
-- Apply your preferred settings

if not vim.g.loaded_netrwPlugin then
  vim.g.netrw_banner = 0
  vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
  vim.g.netrw_liststyle = 3 -- Default to tree view
  vim.g.netrw_localrmdir = 'rm -r'
end
