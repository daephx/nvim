local dap = require("dap")

dap.adapters.unity = {
  type = "executable",
  command = "<path-to-mono-directory>/Commands/mono",
  args = { "<path-to-unity-debug-directory>/unity.unity-debug-x.x.x/bin/UnityDebug.exe" },
}

vim.tbl_extend("force", dap.configurations.cs, {
  name = "Launch unity editor",
  type = "unity",
  request = "attach",
})
