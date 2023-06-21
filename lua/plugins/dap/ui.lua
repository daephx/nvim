local dap = require("dap")
local dapui = require("dapui")

local group = vim.api.nvim_create_augroup("DapUIHooks", {})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "dap-repl" },
  group = group,
  callback = function()
    require("dap.ext.autocompl").attach()
    vim.opt_local.buflisted = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})
