-- Telescope config | configurations for telescope fuzzy-finder
-- https://github.com/nvim-telescope/telescope.nvim

---@type LazyPluginSpec
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
  -- stylua: ignore
  keys = {
    { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
    -- Find
    { "<leader>f'", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>f.", "<cmd>Telescope dotfiles<cr>", desc = "Dotfiles" },
    { "<leader>f:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>f\"", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>", desc = "Buffers" },
    { "<leader>fB", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Grep Buffer" },
    { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
    { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
    { "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
    { "<leader>fF", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fH", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>fh", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
    { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Goto Symbol" },
    { "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Goto Symbol (Workspace)" },
    { "<leader>fv", "<cmd>Telescope vimfiles<cr>", desc = "Neovim config" },
    { "<leader>f~", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    -- Git
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
    { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
  },
  opts = function()
    local action_set = require("telescope.actions.set")
    local actions = require("telescope.actions")
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
        selection_strategy = "reset",
        sorting_strategy = "ascending",

        -- Default settings for layout themes
        layout_config = {
          height = 0.5,
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

        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--column",
          "--line-number",
          "--no-heading",
          "--smart-case",
          "--with-filename",
        },

        -- Custom mappings for telescope prompt
        mappings = {
          i = {
            -- Add common alternative to close prompt
            ["qq"] = actions.close,
            ["jk"] = actions.close,

            -- Disable key mappings to prevent accidental actions
            ["<C-m>"] = nil,

            -- Allow ctrl-u to clear search prompt
            ["<C-u>"] = false,

            -- Replace Tab multi-select with simple navigation.
            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,

            -- Set extra keybindings for preview navigation
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Down>"] = actions.preview_scrolling_down,
            ["<C-Left>"] = actions.preview_scrolling_left,
            ["<C-Right>"] = actions.preview_scrolling_right,
            ["<C-PageUp>"] = actions.preview_scrolling_up,
            ["<C-PageDown>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

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
          },
        },

        -- File patterns to exclude from fuzzy results
        file_ignore_patterns = {
          "*.pyc", -- Python cache
          ".git/", -- Git version control files
          ".pytest_cache/", -- Pytest unittest cache files
          ".venv/", -- Python virtual environment
          ".yarn/", -- Yarn package directory
          "__pycache__/", -- Python cache files
          "_build/", -- Jekyll build directory
          "build/", -- General build artifacts
          "node_modules/", -- Node module environment
          "nvim/runtime/doc/", -- Vim documentation
          "out/", -- CMake default build directory
          "src/parser.c", -- Treesitter parsers
          "tags/", -- Tag files
        },
      }),

      -- Default configuration for builtin pickers goes here:
      pickers = {
        man_pages = { sections = { "2", "3" } },
        lsp_document_diagnostics = { theme = "ivy" },
        lsp_document_symbols = { path_display = { "hidden" } },
        lsp_references = { path_display = { "shorten" } },
        lsp_workspace_symbols = { path_display = { "shorten" } },
        colorscheme = {
          previewer = false,
          on_complete = false,
          layout_config = { height = 12 },
        },
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
    -- Some plugins specs don't cleanly handle lazy loading telescope integrations
    -- Here we can safely initialize them when telescope is finally loaded.
    pcall(function()
      -- Local
      telescope.load_extension("dotfiles")
      telescope.load_extension("vimfiles")

      -- Auto-session
      require("auto-session").setup_session_lens()
      telescope.load_extension("session-lens")

      -- Project_nvim
      telescope.load_extension("projects")
    end)

    --- Autocmds ---

    vim.api.nvim_create_autocmd("User", {
      desc = "Enable line wrap in previewer",
      group = vim.api.nvim_create_augroup("TelescopePreviewerWrap", {}),
      pattern = "TelescopePreviewerLoaded",
      command = "setlocal wrap",
    })
  end,
  init = function()
    local colors = require("config.colors")
    colors.set_hl_autocmd(nil, {
      TelescopeBorder = { link = "FloatBorder", default = true },
      TelescopePreviewBorder = { link = "FloatBorder", default = true },
      TelescopePromptBorder = { link = "FloatBorder", default = true },
      TelescopeResultsBorder = { link = "FloatBorder", default = true },
      TelescopeSelection = { link = "CursorLine", default = true },
      TelescopeTitle = { link = "Title", default = true },
    })
  end,
}
