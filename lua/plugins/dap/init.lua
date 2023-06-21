-- DAP | Debug Adapter Protocol

local initialize_keymaps = function()
  map("n", "<leader>dC", '<cmd>lua require("dap").continue()<CR>')
  map("n", "<leader>db", '<cmd>lua require("dap").toggle_breakpoint()<CR>')
  map(
    "n",
    "<leader>dB",
    '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>'
  )
  map("n", "<leader>do", '<cmd>lua require("dap").step_over()<CR>')
  map("n", "<leader>dO", '<cmd>lua require("dap").step_out()<CR>')
  map("n", "<leader>dn", '<cmd>lua require("dap").step_into()<CR>')
  map("n", "<leader>dN", '<cmd>lua require("dap").step_back()<CR>')
  map("n", "<leader>dr", '<cmd>lua require("dap").repl.toggle()<CR>')
  map("n", "<leader>d.", '<cmd>lua require("dap").goto_()<CR>')
  map("n", "<leader>dh", '<cmd>lua require("dap").run_to_cursor()<CR>')
  map("n", "<leader>de", '<cmd>lua require("dap").set_exception_breakpoints()<CR>')
  map("n", "<leader>dv", "<cmd>Telescope dap variables<CR>")
  map("n", "<leader>dc", "<cmd>Telescope dap commands<CR>")
  map("n", "<leader>dx", '<cmd>lua require("dapui").eval()<CR>')
  map("x", "<leader>dx", '<cmd>lua require("dapui").eval()<CR>')
  map("n", "<leader>dX", '<cmd>lua require("dapui").eval(vim.fn.input("expression: "))<CR>')
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

return {
  { -- Debug adapter protocol client
    "mfussenegger/nvim-dap",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "jbyuki/one-small-step-for-vimkind" },
      -- bridges mason.nvim with the nvim-dap
      { "jay-babu/mason-nvim-dap.nvim" },
    },
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Set Breakpoint" },
      { "<leader>dn", "<cmd>DapContinue<CR>", desc = "Continue debugging" },
    },
    config = function()
      local dap = require("dap")

      -- Set default highlights
      vim.api.nvim_set_hl(0, "DapBreakpoint", { default = true, link = "Error" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- Define Debugging signs
      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapLogPoint", { text = "󰍪 ", texthl = "debugBreakpoint" })
      vim.fn.sign_define("DapStopped", { text = "●", texthl = "DiagnosticsHint" })

      dap.listeners.after["event_initialized"]["dapui"] = function()
        require("dapui").open()
      end
      dap.listeners.after["event_terminated"]["dapui"] = function()
        require("dapui").close()
      end

      initialize_keymaps()
      -- initialize adapters/configs for languages
      for _, lang in pairs(languages) do
        if not pcall(require, "plugins.dap." .. lang) then
          error("DAP: Config for " .. lang .. " is not defined!")
          return
        end
      end

      vim.cmd([[
      function! SetupREPL()
        lua require("dap.ext.autocompl").attach()
        setlocal nobuflisted
        setlocal nonumber
        setlocal norelativenumber
        setlocal signcolumn=no
      endfunction

      augroup dapui_au
        autocmd!
        autocmd FileType dap-repl call SetupREPL()
      augroup END
      ]])
    end,
  },
  { -- Integration for nvim-dap with telescope.nvim
    "nvim-telescope/telescope-dap.nvim",
    cmd = "Telescope",
    config = function()
      require("telescope").load_extension("dap")
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
    },
  },
}
