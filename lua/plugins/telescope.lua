-- Telescope config | configurations for telescope fuzzy-finder
-- https://github.com/nvim-telescope/telescope.nvim
local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

local state = require("telescope.state")
local action_set = require("telescope.actions.set")

local M = {}

telescope.setup({
  -- Default configuration for telescope goes here:
  defaults = themes.get_ivy({
    prompt_prefix = "> ",
    color_devicons = true,
    dynamic_preview_title = true,
    scroll_strategy = "cycle",
    winblend = 5,

    file_sorter = sorters.get_fuzzy_file,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,

    vimgrep_arguments = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },

    layout_config = { -- Default settings for layout themes
      prompt_position = "top",
      horizontal = {
        width = 0.9,
        height = 0.95,
        preview_width = 0.55,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },

    mappings = { -- Custom mappings for telescope prompt
      i = {
        ["qq"] = actions.close,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-h>"] = "which_key",
        ["<C-PageUp>"] = "preview_scrolling_up",
        ["<C-PageDown>"] = "preview_scrolling_down",

        -- Scroll results by half/page
        ["<PageUp>"] = function(prompt_bufnr)
          local results_win = state.get_status(prompt_bufnr).results_win
          local height = vim.api.nvim_win_get_height(results_win)
          action_set.shift_selection(prompt_bufnr, -math.floor(height / 2))
        end,
        ["<PageDown>"] = function(prompt_bufnr)
          local results_win = state.get_status(prompt_bufnr).results_win
          local height = vim.api.nvim_win_get_height(results_win)
          action_set.shift_selection(prompt_bufnr, math.floor(height / 2))
        end,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },

    -- File patterns to exclude from fuzzy results
    file_ignore_patterns = {
      "*.pyc", -- Python cache
      ".git", -- Git version control files
      ".pytest_cache", -- Pytest unittest cache files
      ".venv", -- Python virtual environment
      ".yarn", -- Yarn package directory
      "__pycache__", -- Python cache files
      "_build", -- Build artifacts
      "build", -- Build artifacts
      "node_modules", -- Node module environment
      "nvim/runtime/doc", -- Vim documentation
      "src/parser.c", -- Treesitter parsers
      "tags", -- Tag files
    },
  }),
  -- Default configuration for builtin pickers goes here:
  pickers = {
    man_pages = { sections = { "2", "3" } },
    lsp_code_actions = { theme = "cursor" },
    lsp_document_diagnostics = { theme = "ivy" },
    lsp_document_symbols = { path_display = { "hidden" } },
    lsp_references = { path_display = { "shorten" } },
    lsp_workspace_symbols = { path_display = { "shorten" } },
    colorscheme = { theme = "dropdown", previewer = false },
    buffers = {
      sort_mru = true,
      selection_strategy = "closest",
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
        },
        n = {
          ["<c-d>"] = actions.delete_buffer,
        },
      },
    },
  },
})

-- Highlights
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })

--- Pickers ---

-- Search dotfiles folder
-- Path Specified via DOTFILES environment variable
M.search_dotfiles = function()
  builtin.find_files({
    prompt_title = "< Dotfiles >",
    cwd = vim.env.DOTFILES,
    hidden = true,
    file_ignore_patterns = {
      "meta/dotbot/.*",
      "meta/dotbot/plugins/.*",
    },
  })
end

-- Search vimfiles folder
-- Uses standard config path '.config/nvim'
M.search_vimfiles = function()
  builtin.find_files({
    prompt_title = "< VimRC >",
    cwd = vim.fn.stdpath("config"),
    hidden = true,
  })
end

return M
