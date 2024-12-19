-- vscode-js-debug | VS Code JavaScript debugger
-- https://github.com/microsoft/vscode-js-debug

local dap = require("dap")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local js_debug_bin = mason_packages .. "/js-debug-adapter/js-debug/src/dapDebugServer.js"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { js_debug_bin, "${port}" },
  },
}

local config = {}

table.insert(config, {
  type = "pwa-node",
  request = "launch",
  name = "Launch file",
  program = "${file}",
  cwd = "${workspaceFolder}",
})

table.insert(config, {
  type = "pwa-node",
  request = "attach",
  name = "Attach",
  processId = require("dap.utils").pick_process,
  cwd = "${workspaceFolder}",
})

table.insert(config, {
  type = "pwa-chrome",
  request = "attach",
  name = "Attach Program (pwa-chrome, select port)",
  program = "${file}",
  cwd = vim.fn.getcwd(),
  sourceMaps = true,
  port = function()
    return vim.fn.input("Select port: ", "9222")
  end,
  webRoot = "${workspaceFolder}",
})

table.insert(config, {
  type = "pwa-node",
  request = "launch",
  name = "Debug Jest Tests",
  runtimeExecutable = "node",
  runtimeArgs = { "./node_modules/jest/bin/jest.js", "--runInBand" },
  rootPath = "${workspaceFolder}",
  cwd = "${workspaceFolder}",
  console = "integratedTerminal",
  internalConsoleOptions = "neverOpen",
})

table.insert(config, {
  type = "pwa-node",
  request = "launch",
  name = "Debug Mocha Tests",
  runtimeExecutable = "node",
  runtimeArgs = { "./node_modules/mocha/bin/mocha.js" },
  rootPath = "${workspaceFolder}",
  cwd = "${workspaceFolder}",
  console = "integratedTerminal",
  internalConsoleOptions = "neverOpen",
})

dap.configurations.javascript = config
