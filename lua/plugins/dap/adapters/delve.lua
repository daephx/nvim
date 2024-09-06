-- delve | DAP configuration for go
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go
local dap = require("dap")
local utils = require("dap.utils")

dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
  options = {
    initialize_timeout_sec = 20,
  },
}

local function get_arguments()
  local co = coroutine.running()
  if co then
    return coroutine.create(function()
      local args = {}
      vim.ui.input({ prompt = "Args: " }, function(input)
        args = vim.split(input or "", " ")
      end)
      coroutine.resume(co, args)
    end)
  else
    local args = {}
    vim.ui.input({ prompt = "Args: " }, function(input)
      args = vim.split(input or "", " ")
    end)
    return args
  end
end

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
    console = "integratedTerminal",
  },
  {
    type = "go",
    name = "Debug (Arguments)",
    request = "launch",
    program = "${file}",
    console = "integratedTerminal",
    args = get_arguments,
  },
  {
    type = "go",
    name = "Debug Package",
    request = "launch",
    program = "${fileDirname}",
    console = "integratedTerminal",
  },
  {
    type = "go",
    name = "Attach",
    mode = "local",
    request = "attach",
    processId = utils.pick_process,
  },
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}
