local dap = require("dap")

dap.adapters.perlsp = {
  type = "server",
  host = "127.0.0.1",
  port = "27011",
}

dap.configurations.perl = {
  {
    name = "Launch Perl",
    type = "perlsp",
    request = "launch",
    program = "${workspaceFolder}/${relativeFile}",
    reloadModules = true,
    stopOnEntry = false,
    cwd = "${workspaceFolder}",
  },
}
