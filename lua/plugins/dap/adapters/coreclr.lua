local dap = require("dap")

dap.adapters.coreclr = {
  type = "executable",
  command = "netcoredbg",
  args = { "--interpreter=vscode" },
}

local dotnet_build_project = function()
  local default_path = vim.fn.getcwd() .. "/"
  if vim.g["dotnet_last_proj_path"] ~= nil then
    default_path = vim.g["dotnet_last_proj_path"]
  end
  local path = vim.fn.input("Path to your *proj file", default_path, "file")
  vim.g["dotnet_last_proj_path"] = path
  local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
  print("")
  print("Cmd to execute: " .. cmd)
  local f = os.execute(cmd)
  if f == 0 then
    print("\nBuild: ✔️ ")
  else
    print("\nBuild: ❌ (code: " .. f .. ")")
  end
end

local dotnet_get_dll_path = function()
  local request = function()
    local cwd = vim.fn.getcwd()
    local proj = vim.fn.fnamemodify(cwd, ":t")
    local path = ("%s/bin/Debug/net6.0/%s.dll"):format(cwd, proj)
    return vim.fn.input("Path to dll: ", path, "file")
  end

  if vim.g["dotnet_last_dll_path"] == nil then
    vim.g["dotnet_last_dll_path"] = request()
  else
    local prompt = "Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"]
    if vim.fn.confirm(prompt, "&yes\n&no", 2) == 1 then
      vim.g["dotnet_last_dll_path"] = request()
    end
  end

  return vim.g["dotnet_last_dll_path"]
end

local telescope_picker = function()
  return coroutine.create(function(coro)
    local action_state = require("telescope.actions.state")
    local actions = require("telescope.actions")
    local conf = require("telescope.config").values
    local finders = require("telescope.finders")
    local pickers = require("telescope.pickers")
    local opts = {}
    pickers
      .new(opts, {
        prompt_title = "Path to executable",
        finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(bufnr)
          actions.select_default:replace(function()
            actions.close(bufnr)
            coroutine.resume(coro, action_state.get_selected_entry()[1])
          end)
          return true
        end,
      })
      :find()
  end)
end

local config = {
  {
    type = "coreclr",
    request = "launch",
    name = "Launch project (netcoredbg)",
    console = "integratedTerminal",
    program = function()
      if vim.fn.confirm("Attempt to rebuild project?", "&yes\n&no", 2) == 1 then
        dotnet_build_project()
      end
      return dotnet_get_dll_path()
    end,
  },
  {
    type = "coreclr",
    request = "launch",
    name = "Launch DLL (netcoredbg)",
    program = function()
      local dir = vim.fn.expand("%:p:h")
      local path = ("%s/bin/Debug/"):format(dir)
      return vim.fn.input("Path to DLL: ", path, "file")
    end,
  },
  {
    type = "coreclr",
    request = "launch",
    name = "Select DLL (telescope)",
    program = telescope_picker,
  },
  {
    type = "coreclr",
    request = "attach",
    name = "Attach to PID (netcoredbg)",
    processId = function()
      local pid = require("dap.utils").pick_process()
      vim.fn.setenv("NETCOREDBG_ATTACH_PID", pid)
      return pid
    end,
  },
}

dap.configurations.cs = config
dap.configurations.fsharp = config
