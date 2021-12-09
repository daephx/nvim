-- You must Install debugpy for this to work!
--
-- python -m venv path/to/virtualenvs/debugpy
-- path/to/virtualenvs/debugpy/bin/python -m pip install debugpy

local dap = require('dap')

-- You can then either use nvim-dap-python - it comes with adapter and configurations definitions
dap.adapters.python = {
  type = 'executable';
  command = 'python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}


local M = {}

M.attach_python_debugger = function(args)
  local host = args[1] -- This should be configured for remote debugging if your SSH tunnel is setup.
  local port = '5678'
  -- You can even make nvim responsible for starting the debugpy server/adapter:
  --  vim.fn.system({"${some_script_that_starts_debugpy_in_your_container}", ${script_args}})
  pythonAttachAdapter = {
    type = "server";
    host = host;
    port = tonumber(port);
  }
  pythonAttachConfig = {
    type = "python";
    request = "attach";
    connect = {
      port = tonumber(port);
      host = host;
    };
    mode = "remote";
    name = "Remote Attached Debugger";
    cwd = vim.fn.getcwd();
    pathMappings = {
      {
        localRoot = vim.fn.getcwd(); -- Wherever your Python code lives locally.
        remoteRoot = "/usr/src/app"; -- Wherever your Python code lives in the container.
      };
    };
  }
  local session = dap.attach(host, tonumber(port), pythonAttachConfig)
  if session == nil then
    io.write("Error launching adapter");
  end
  dap.repl.open()
end

return M
