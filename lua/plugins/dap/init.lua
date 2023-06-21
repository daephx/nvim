-- nvim-dap | Debug Adapter Protocol client implementation for neovim
-- https://github.com/mfussenegger/nvim-dap

return {
  { -- Debug adapter protocol client
    "mfussenegger/nvim-dap",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    dependencies = {
      -- bridges mason.nvim with the nvim-dap
      { "jay-babu/mason-nvim-dap.nvim" },
      -- Debug adapter for Neovim plugins
      { "jbyuki/one-small-step-for-vimkind" },
    },
    -- stylua: ignore
    keys = {
      { "<F3>", function() require("dap").repl.toggle({ height = 20 }) end, desc = "Toggle REPL" },
      { "<F4>", function() require("dap").terminate() end, desc = "Terminate" },
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<F6>", function() require("dap").pause() end, desc = "Pause" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Set breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Set breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
      { "<leader>de", function() require("dap").set_exception_breakpoints() end, desc = "Exception breakpoint" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>dh", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
      { "<leader>dL", function() require("dap").toggle_breakpoint(nil, nil, vim.fn.input("Log point message: "), true) end, desc = "Set log breakpoint" },
      { "<leader>dN", function() require("dap").step_back() end, desc = "Step back" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle({ height = 20 }) end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
      -- Set default highlights
      vim.api.nvim_set_hl(0, "DapBreakpoint", { default = true, link = "Error" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- Set custom sign icons
      local icons = require("core.icons").dap
      for name, sign in pairs(icons) do
        sign = type(sign) == "table" and sign or { sign }
        name = "Dap" .. name
        local text = sign[1] .. " "
        local texthl = sign[2] or name
        vim.fn.sign_define(name, { text = text, texthl = texthl, linehl = sign[3], numhl = sign[3] })
      end

      -- Languages defined here will be looked for in the plugin.dap module,
      -- Any lua script with the corresponding name will be loaded if found.
      -- i.e. lua/plugins/dap/python.lua

      local languages = {
        -- "cpp",
        -- "cs",
        -- "go",
        -- "ruby",
        -- "lua",
        "python",
        -- "rust",
        -- "javascript",
      }

      -- initialize adapters/configs for languages
      for _, lang in pairs(languages) do
        if not pcall(require, "plugins.dap.settings" .. lang) then
          error("DAP: Config for " .. lang .. " is not defined!")
          return
        end
      end
    end,
  },
  { -- Fancy UI for the debugger
    "rcarriga/nvim-dap-ui",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    dependencies = { "mfussenegger/nvim-dap" },
    -- stylua: ignore
    keys = {
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
      { "<leader>dE", function() require("dapui").eval(vim.fn.input("expression: ")) end, desc = "Eval Expression" },
      { "<leader>du", function() require("dapui").toggle({ reset = true }) end, desc = "Dap UI" },
    },
    opts = {
      expand_lines = false,
      floating = { border = vim.g.border },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "right",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 0.25,
        },
      },
    },
    config = function(_, opts)
      require("dapui").setup(opts)
      require("plugins.dap.ui")
    end,
  },
  { -- virtual text for the debugger
    "theHamsta/nvim-dap-virtual-text",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      show_stop_reason = false,
    },
  },
  { -- Integration for nvim-dap with telescope.nvim
    "nvim-telescope/telescope-dap.nvim",
    cmd = { "DapContinue", "DapToggleBreakpoint", "Telescope" },
    dependencies = {
      -- Debug adapter protocol client
      "mfussenegger/nvim-dap",
      -- A highly extendable fuzzy finder for neovim
      "nvim-telescope/telescope.nvim",
    },
    -- stylua: ignore
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dd", "<cmd>Telescope dap commands<CR>", desc = "Commands" },
      { "<leader>dv", "<cmd>Telescope dap variables<CR>", desc = "Variables" },
    },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
}
