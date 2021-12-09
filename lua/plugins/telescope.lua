-- Module: plugins.telescope
-- Description: configurations for telescope fuzzy-finder

local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')

local state = require('telescope.state')
local action_set = require 'telescope.actions.set'

local M = {}

M.config = function()
  telescope.setup {
    defaults = { -- Default configuration for telescope goes here:
      prompt_prefix='> ',
      color_devicons = true,
      dynamic_preview_title = true,
      -- layout_strategy= 'flex',
      -- scroll_strategy = 'cycle',
      scroll_strategy = 'limit',
      selection_strategy = 'row',
      sorting_strategy = 'ascending',
      winblend = 5,

      -- file_sorter = sorters.get_fzy_sorter,
      file_sorter = sorters.get_fuzzy_file,
      file_previewer = previewers.vim_buffer_cat.new,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      qflist_previewer = previewers.vim_buffer_qflist.new,

      vimgrep_arguments = {
        'rg',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },

      -- Set character list for prompt borders
      border = {},
      borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'}, -- Rounded corners
      -- borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'}, -- Square Corners

      layout_config = { -- Default settings for layout themes
        prompt_position = 'top',
        horizontal = {
          width = 0.9,
          height = 0.95,
          preview_width = 0.55
        },
        vertical = {
          width_padding = 0.05,
          height_padding = 1,
          preview_height = 0.5
        },
      },

      mappings = { -- Custom mappings for telescope prompt
        i = {
          ['qq'] = actions.close,
          ['<C-u>'] = false,
          ['<C-d>'] = false,
          ['<C-h>'] = 'which_key',
          ['<C-PageUp>'] = 'preview_scrolling_up',
          ['<C-PageDown>'] = 'preview_scrolling_down',

          -- Scroll results by half/page
          ['<PageUp>'] = function(prompt_bufnr)
            local results_win = state.get_status(prompt_bufnr).results_win
            local height = vim.api.nvim_win_get_height(results_win)
            action_set.shift_selection(prompt_bufnr, -math.floor(height/2))
          end,
          ['<PageDown>'] = function(prompt_bufnr)
            local results_win = state.get_status(prompt_bufnr).results_win
            local height = vim.api.nvim_win_get_height(results_win)
            action_set.shift_selection(prompt_bufnr, math.floor(height/2))
          end,
        },
        n = {
          ['<esc>'] = actions.close,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        }
      },

      file_ignore_patterns = { -- File patterns to exclude from fuzzy resaults
        '*.pyc', -- Python cache
        '*.git/.*', -- Git version control directory
        '.pytest_cache/.*', -- Pytest unittest cache files
        '__pycache__/.*', -- Python cache files
        '_build/.*',
        'build/.*',
        'node_modules/.*', -- Node module environment
        'src/parser.c',
        'tags/.*',
      },
    },
    pickers = { -- Default configuration for builtin pickers goes here:

      -- Now the picker_config_key will be applied every time you call this
      buffers = {
        sort_mru = true,
        theme = 'ivy',
        selection_strategy = 'closest',
        mappings = {
          i = {
            -- ['<c-w>'] =
            ['<c-d>'] = actions.delete_buffer,
          },
        }
      },
      man_pages = { sections = { '2', '3' } },
      lsp_references = { path_display = { 'shorten' } },
      lsp_document_symbols = { path_display = { 'hidden' } },
      lsp_document_diagnostics = { theme = 'ivy' },
      lsp_workspace_symbols = { path_display = { 'shorten' } },
      lsp_code_actions = { theme = 'dropdown' },
      current_buffer_fuzzy_find = { theme = 'dropdown', previewer = false },
      colorscheme = { theme = 'dropdown', previewer = false },
      file_browser = { theme = 'ivy' },
    },
    extensions = { -- Your extension configuration goes here:
      -- please take a look at the readme of the extension you want to configure
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
        -- the default case_mode is 'smart_case'
      },
      media_files = {
        -- filetypes whitelist
        -- defaults to {'png', 'jpg', 'mp4', 'webm', 'pdf'}
        filetypes = {'png', 'webp', 'jpg', 'jpeg'},
        find_cmd  = 'rg' -- find command (defaults to `fd`)
      },
    }
  }


  -- Highlights

  vim.cmd [[highlight TelescopeNormal guibg=none]]

end


--- Extensions ---


-- Pickers

-- Search dotfiles folder
-- Path Specified via DOTFILES environment variable
M.search_dotfiles = function()
  builtin.find_files({
    prompt_title = '< Dotfiles >',
    cwd = vim.env.DOTFILES,
    hidden = true,
    file_ignore_patterns = {
      "meta/dotbot/.*",
      "meta/dotbot/plugins/.*",
    }
  })
end

-- Search vimfiles folder
-- Uses standard config path '.config/nvim'
M.search_vimfiles = function()
  builtin.find_files({
    prompt_title = '< VimRC >',
    cwd = vim.fn.stdpath('config'),
    hidden = true,
  })
end

-- Search Notes/Wiki folder
-- HACK: fix, Telescope wiki path currently hardcoded
M.search_wikifiles = function()
  builtin.find_files({
    prompt_title = '< Wiki >',
    cwd = '~/Documents/wiki',
    hidden = true,
  })
end

-- Search files tracked by git
M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(builtin.git_files, opts)
  if not ok then builtin.find_files(opts) end
end

M.todo_comments = function()
  local opts = {}
  builtin.live_grep(opts)
end

-- Display git branches
M.git_branches = function()
  builtin.git_branches({
    prompt_prefix = ' ',
    layout_strategy = 'bottom_pane',
    attach_mappings = function(_, map)
      map('i', '<c-d>', actions.git_delete_branch)
      map('n', '<c-d>', actions.git_delete_branch)
      return true
    end,
  })
end

-- Language server diagnostics
M.lsp_workspace_diagnostics = function()
  builtin.lsp_workspace_diagnostics {
    layout_strategy = 'vertical',
  }
end

return M
