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

local function pick_executable()
  -- Get list of executable files (synchronous)
  local handle = io.popen("fd --hidden --no-ignore --type x")
  if handle == nil then
    return nil
  end
  local files = {}
  for line in handle:lines() do
    table.insert(files, line)
  end
  handle:close()

  local result = nil
  local chosen = false

  vim.ui.select(files, {
    prompt = "Path to executable",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    result = choice
    chosen = true
  end)

  vim.wait(100000, function()
    return chosen
  end)
  return result
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
    name = "Select DLL",
    program = pick_executable,
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
