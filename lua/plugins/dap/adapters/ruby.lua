local dap = require("dap")

dap.adapters.ruby = function(callback, config)
  callback({
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "bundle",
      args = {
        "exec",
        "rdbg",
        "-n",
        "--open",
        "--port",
        "${port}",
        "-c",
        "--",
        "bundle",
        "exec",
        config.command,
        config.script,
      },
    },
  })
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "Launch file (rdbg)",
    request = "attach",
    localfs = true,
    command = "ruby",
    script = "${file}",
  },
  {
    type = "ruby",
    name = "Launch current spec file",
    request = "attach",
    localfs = true,
    command = "rspec",
    script = "${file}",
  },
  {
    name = "Launch Rails (bundler)",
    type = "ruby",
    request = "launch",
    program = "bundle",
    programArgs = { "exec", "rails", "s" },
    useBundler = true,
  },
}
