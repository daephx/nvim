-- Telescope config | configurations for telescope fuzzy-finder
-- https://github.com/nvim-telescope/telescope.nvim

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    -- Collection of useful lua functions
    { "nvim-lua/plenary.nvim" },
    -- Popup API from vim in Neovim
    { "nvim-lua/popup.nvim" },
    -- Adds file type icons to Vim plugins
    { "nvim-tree/nvim-web-devicons" },
  },
  keys = {
    { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>f.", "<cmd>Telescope dotfiles<CR>", desc = "Dotfiles" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fB", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Grep Buffer" },
    { "<leader>fc", "<cmd>Telescope colorscheme<CR>", desc = "Colorschemes" },
    { "<leader>fC", "<cmd>Telescope commands<CR>", desc = "Commands" },
    { "<leader>fd", "<cmd>Telescope lsp_document_diagnostics<CR>", desc = "LSP Diagnostics" },
    { "<leader>fe", "<cmd>Telescope file_browser<CR>", desc = "File Explorer" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Current Files" },
    { "<leader>fF", "<cmd>Telescope treesitter<CR>", desc = "Treesitter" },
    { "<leader>fh", "<cmd>Telescope highlights<CR>", desc = "Highlight Groups" },
    { "<leader>fl", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
    { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "Bookmarks" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files" },
    { "<leader>fs", "<cmd>Telescope grep_string<CR>", desc = "Grep String" },
    { "<leader>fv", "<cmd>Telescope vimfiles<CR>", desc = "Neovim config" },
    { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Branches" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "Files" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
  },
  opts = function()
    local action_set = require("telescope.actions.set")
    local actions = require("telescope.actions")
    local previewers = require("telescope.previewers")
    local sorters = require("telescope.sorters")
    local state = require("telescope.state")
    local themes = require("telescope.themes")
    return {
      defaults = themes.get_ivy({
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        color_devicons = true,
        dynamic_preview_title = false,
        preview_title = "",
        results_title = false,
        scroll_strategy = "cycle",
        selection_strategy = "row",
        sorting_strategy = "ascending",
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

        -- Default settings for layout themes
        layout_config = {
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

        -- Custom mappings for telescope prompt
        mappings = {
          i = {
            ["qq"] = actions.close,
            ["jk"] = actions.close,
            ["<C-u>"] = false,
            ["<C-h>"] = "which_key",
            ["<C-d>"] = false,
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
            ["q"] = actions.close,
            ["jk"] = actions.close,
            ["<esc>"] = actions.close,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
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
        lsp_document_diagnostics = { theme = "ivy" },
        lsp_document_symbols = { path_display = { "hidden" } },
        lsp_references = { path_display = { "shorten" } },
        lsp_workspace_symbols = { path_display = { "shorten" } },
        colorscheme = { previewer = false, layout_config = { height = 12 } },
        find_files = { hidden = true },
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

      -- Telescope extension configuration
      extensions = {
        dotfiles = {
          file_ignore_patterns = {
            "meta/dotbot/.*",
            "meta/dotbot/plugins/.*",
          },
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    -- Load extensions
    telescope.load_extension("dotfiles")
    telescope.load_extension("vimfiles")

    --- Autocmds ---

    vim.api.nvim_create_autocmd("User", {
      desc = "Enable line wrap in previewer",
      group = vim.api.nvim_create_augroup("TelescopePreviewerWrap", {}),
      pattern = "TelescopePreviewerLoaded",
      command = "setlocal wrap",
    })

    -- HACK: https://github.com/nvim-telescope/telescope.nvim/issues/2027#issuecomment-1510001730
    vim.api.nvim_create_autocmd({ "WinLeave" }, {
      desc = "Prevent entering buffers in insert mode",
      group = vim.api.nvim_create_augroup("TelescopePromptInsertFix", {}),
      callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "i",
            false
          )
        end
      end,
    })
  end,
}
