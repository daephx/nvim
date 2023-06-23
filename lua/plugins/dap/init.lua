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
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    dependencies = {
      -- Debug adapter for Neovim plugins
      { "jbyuki/one-small-step-for-vimkind" },
      -- bridges mason.nvim with the nvim-dap
      { "jay-babu/mason-nvim-dap.nvim" },
    },
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Set Breakpoint" },
      { "<leader>dn", "<cmd>DapContinue<CR>", desc = "Continue debugging" },
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

      initialize_keymaps()
      -- initialize adapters/configs for languages
      for _, lang in pairs(languages) do
        if not pcall(require, "plugins.dap." .. lang) then
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
