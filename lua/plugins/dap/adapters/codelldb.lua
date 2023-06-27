local dap = require("dap")

dap.adapters.codelldb = {
  name = "codelldb server",
  type = "server",
  port = "${port}",
  detached = false,
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

local config = {}

table.insert(config, {
  type = "codelldb",
  request = "launch",
  name = "Launch file (codelldb)",
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  stopOnExit = true,
  runInTerminal = true,
  terminal = "integrated",
  program = function()
    local cwd = vim.fn.getcwd() .. "/"
    return vim.fn.input("Path to executable: ", cwd, "file")
  end,
})

table.insert(config, {
  name = "Attach PID",
  type = "codelldb",
  request = "attach",
  pid = require("dap.utils").pick_process,
})

table.insert(config, {
  name = "Attach to Name (wait)",
  request = "attach",
  type = "codelldb",
  program = function()
    local cwd = vim.fn.getcwd() .. "/"
    return vim.fn.input("Path to executable: ", cwd, "file")
  end,
  waitFor = true,
})

-- If you want to use this for Rust and C, add something like this:
dap.configurations.c = config
dap.configurations.cpp = config
dap.configurations.h = config
dap.configurations.rust = config
