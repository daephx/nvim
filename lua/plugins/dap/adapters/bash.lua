-- bashdb | Bash shell debugger extension
-- https://github.com/rogalmic/vscode-bash-debug

local dap = require("dap")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local bashdb_dir = mason_packages .. "/bash-debug-adapter/extension/bashdb_dir"

dap.adapters.bashdb = {
  type = "executable",
  command = "bash-debug-adapter",
  name = "bashdb",
}

dap.configurations.sh = {
  {
    type = "bashdb",
    request = "launch",
    name = "Launch file",
    showDebugOutput = true,
    pathBashdb = bashdb_dir .. "/bashdb",
    pathBashdbLib = bashdb_dir,
    trace = true,
    file = "${file}",
    program = "${file}",
    cwd = "${workspaceFolder}",
    pathCat = "cat",
    pathBash = "/bin/bash",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    terminalKind = "integrated",
    args = {},
    env = {},
  },
}
