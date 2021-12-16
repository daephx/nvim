local bufferline = require('bufferline')

bufferline.setup {
  options = {
    -- numbers = 'none' | 'ordinal' | 'buffer_id' | 'both' | function({ ordinal, id, lower, raise }): string,
    --- deprecated, please specify numbers as a function to customize the styling
    -- number_style = 'superscript' | 'subscript' | '' | { 'none', 'subscript' }, -- buffer_id at index 1, ordinal at index 2
    close_command = 'bdelete! %d',       -- can be a string | function, see 'Mouse actions'
    right_mouse_command = nil, -- can be a string | function, see 'Mouse actions'
    left_mouse_command = 'buffer %d',    -- can be a string | function, see 'Mouse actions'
    middle_mouse_command = nil,          -- can be a string | function, see 'Mouse actions'
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a 'name', 'path' and 'bufnr'
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = false,
    custom_areas = {},
    offsets = {{
      filetype = 'NvimTree',
      text = 'File Explorer',
      highlight = 'BufferlineNvimTree',
      -- highlight = 'Directory',
      text_align = 'center',
    }},
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'id',
  },
  highlights = {
    fill = {
      guibg = {
        attribute = "bg",
        highlight = "Pmenu"
      }
    },
  }
}

vim.cmd([[
  highlight! link BufferlineNvimTree TabLine
  highlight       BufferlineNvimTree guifg=#e1e1e1
" highlight! link BufferLineSeparator Constant
" highlight! link BufferLineSeparatorVisible Constant
]])
