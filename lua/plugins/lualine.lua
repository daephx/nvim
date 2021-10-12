require('lualine').setup {
  options = {
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    theme = 'tokyonight',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      {
        'diagnostics',
        -- table of diagnostic sources, available sources:
        -- nvim_lsp, coc, ale, vim_lsp
        sources = {'nvim_lsp', 'coc'}, -- displays diagnostics from defined severity
        sections = {'error', 'warn', 'info', 'hint'},
        -- all colors are in format #rrggbb
        -- diagnostics_color = {
        --   error = '#ff0000',
        --   warning = '#ffff00',
        --   info = '#ffffff',
        --   hint = '#00ff00',
        -- },
        symbols = {error = '', warn = '', info = '', hint = ''},
        update_in_insert = false, -- Update diagnostics in insert mode
      },
    },
    lualine_d = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
