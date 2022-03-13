-- Module: plugins.lualine
-- Description: Blazing fast statusline for neovim, written in pure lua

-- Functions
-- Version control diff values
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- Custom Themes
local custom_codedark = require('lualine.themes.codedark')
-- Change the background of lualine_c section for normal mode
custom_codedark.normal.terminal = {
  bg = '#ffaf00',
  fg = '#262626',
  gui = 'bold',
}

local lualine = require('lualine')

-- Lualine setup configs
lualine.setup({
  options = {
    theme = 'auto',
    padding = 1, -- adds padding to the left and right of components
    icons_enabled = true, -- displays icons in alongside component
    always_divide_middle = false,

    -- Powerline variant
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },

    -- Slanted variant
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },

    disabled_filetypes = {
      'CHADtree',
      'Outline',
      'alpha',
      'NvimTree',
      'coc-explorer',
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    lualine_b = {
      { 'branch', icon = '' },
      { 'diff', source = diff_source },
    },
    lualine_c = {
      {
        'diagnostics',
        update_in_insert = false, -- Update diagnostics in insert mode
        -- table of diagnostic sources, available sources:
        sources = { 'nvim_diagnostic', 'coc', 'ale' },
        -- displays diagnostics from defined severity
        -- sections = {'hint', 'info', 'warn', 'error'},
        symbols = {
          hint = '',
          info = '',
          warn = '',
          error = '',
        },
      },
    },
    lualine_d = { {
      function()
        return '%='
      end,
    } },
    lualine_e = { 'location' },
    lualine_x = { 'filetype', 'encoding', 'fileformat' },
    lualine_y = {},
    lualine_z = { 'progress', 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  -- tabline = {
  --   lualine_a = {'buffers'},
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {'tabs'}
  -- },
  extensions = {
    'fugitive',
    'neoterm',
    -- 'toggleterm', -- Default looks terrible
    -- 'nvim-tree',
    'quickfix',
    'trouble',
  },
})
