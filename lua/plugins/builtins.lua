--     ____        _ ____  _
--    / __ )__  __(_) / /_(_)___  _____
--   / __  / / / / / / __/ / __ \/ ___/
--  / /_/ / /_/ / / / /_/ / / / (__  )
-- /_____/\__,_/_/_/\__/_/_/ /_/____/
--
-- Module: plugins.builtins
-- Description: Configurations on how to handled builtin plugins

local g = vim.g

--- Builtins ---

-- For now, you can just comment the items in this list
-- They will be disable if they are NOT commented.
local disabled_plugins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logiPat',
  'matchit',
  -- 'matchparen',
  -- "netrw",
  -- "netrwFileHandlers",
  -- "netrwPlugin",
  -- "netrwSettings",
  'rrhelper',
  -- "spellfile_plugin",
  'tar',
  'tarPlugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

-- Set variable that tricks vim into thinking
-- the plugin has already been loaded
for _, plugin in pairs(disabled_plugins) do
  g['loaded_' .. plugin] = 1
end

--- Settings ---

-- For the plugins that are still enabled
-- Apply your preferred settings

-- Netrw

if g.loaded_netrwPlugin then
  g.netrw_banner = 0
  g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
  g.netrw_liststyle = 3 -- Default to tree view
  g.netrw_localrmdir = 'rm -r'
end
