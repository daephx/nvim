-- Configuration for snacks.nvim picker module
-- Main configuration is in lua/plugins/snacks/init.lua
-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md

---@type LazySpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    -- Primary actions
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>;", function() Snacks.picker.pickers() end, desc = "List Pickers" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    -- find
    { "<leader>f.", function() Snacks.picker.dotfiles() end, desc = "Find dotfiles" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.colorschemes() end, desc = "ColorSchemes" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>fD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>fe", function() Snacks.picker.explorer() end, desc = "Explorer" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fv", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gD", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>gF", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- gh
    { "<leader>ga", function() Snacks.picker.gh_actions() end, desc = "GitHub Issues (open)" },
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gL", function() Snacks.picker.gh_labels() end, desc = "GitHub Issues (open)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
    -- Grep
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
    -- LSP
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
    { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  },
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    -- Documentation for the picker
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    picker = {
      -- Global layout overrides
      layout = {
        cycle = true,
      },
      -- Specific layout overrides
      layouts = {
        ivy = { layout = { row = -2 } },
        vertical = { layout = { width = 0.8 } },
        vscode = { layout = { border = true } },
      },
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 80,
        },
      },
      matcher = {
        frecency = true, -- frecency bonus
        history_bonus = false, -- give more weight to chronological order
      },
      -- Picker specific settings
      sources = {
        explorer = require("plugins.snacks.sources.explorer"),
        pickers = {
          layout = {
            preset = "vscode",
            hidden = { "preview" },
          },
        },
        colorschemes = {
          layout = {
            preset = "ivy",
            hidden = { "preview" },
            layout = {
              height = 0.2,
            },
          },
        },
        icons = {
          layout = {
            preset = "vscode",
            hidden = { "preview" },
          },
        },
        dotfiles = {
          title = "Dotfiles",
          finder = "files",
          cwd = vim.env.DOTFILES or vim.fs.joinpath(vim.env.HOME, ".dotfiles"),
          hidden = true,
        },
        todo_comments = {
          -- Remove the ugly prompt prefix from todo_comments picker prompt
          on_show = function(picker)
            local input = picker.input
            input.statuscolumn = function()
              return "%#SnacksPickerPrompt# %*"
            end
          end,
        },
      },
      win = {
        input = {
          keys = {
            ["<Home>"] = { "list_top", mode = { "i", "n" } },
            ["<End>"] = { "list_bottom", mode = { "i", "n" } },

            ["<PageUp>"] = { "list_scroll_up", mode = { "i", "n" } },
            ["<PageDown>"] = { "list_scroll_down", mode = { "i", "n" } },

            ["<c-PageUp>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-PageDown>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
