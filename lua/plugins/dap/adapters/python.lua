-- You must Install debugpy for this to work!
--
-- python -m venv path/to/virtualenvs/debugpy
-- path/to/virtualenvs/debugpy/bin/python -m pip install debugpy

local dap = require("dap")
local ok, dap_python = pcall(require, "dap-python")
if ok then
  dap_python.test_runner = "pytest"
end

local get_python_path = function(workspace)
  -- Use activated virtualenv.
  local util = require("lspconfig.util")

  local path = util.path
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace or vim.fn.getcwd(), pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(vim.fs.dirname(match), "bin", "python")
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

-- You can then either use nvim-dap-python - it comes with adapter and configurations definitions
dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",
    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = get_python_path(),
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file with arguments",
    program = "${file}",
    cwd = "${workspaceFolder}",
    args = function()
      local args_string = vim.fn.input("Arguments: ")
      return vim.split(args_string, " +")
    end,
    pythonPath = get_python_path(),
  },
  {
    type = "python",
    request = "attach",
    name = "Attach remote",
    justMyCode = false,
    pythonPath = get_python_path(),
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      return tonumber(vim.fn.input("Port [5678]: ")) or 5678
    end,
  },
}
