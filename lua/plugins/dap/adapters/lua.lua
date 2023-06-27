local dap = require("dap")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local luadb_dir = mason_packages .. "/local-lua-debugger-vscode"

dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    luadb_dir .. "/extension/debugAdapter.js",
  },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      c.extensionPath = luadb_dir
      on_config(c)
    else
      on_config(config)
    end
  end,
}

dap.adapters.nlua = function(callback, config)
  local adapter = {
    type = "server",
    host = "127.0.0.1",
    port = config.port,
  }
  if config.start_neovim then
    local start_opts = config.start_neovim
    config.start_neovim = nil
    local handle
    local pid_or_err
    local opts = {
      args = {
        "-e",
        vim.v.progpath,
        "-c",
        string.format("lua require('osv').launch({ port = %s })", config.port),
        start_opts.fname or vim.api.nvim_buf_get_name(0),
      },
      cwd = start_opts.cwd or vim.fn.getcwd(),
      detached = true,
    }
    local command = "/home/daephx/.local/share/cargo/bin/alacritty"
    handle, pid_or_err = vim.loop.spawn(command, opts, function(code)
      if handle ~= nil then
        handle:close()
      end
      assert(code == 0, "Exit code must be 0, not " .. tostring(code))
    end)
    if not handle then
      error(pid_or_err)
    end
    local timer = vim.loop.new_timer()
    if timer ~= nil then
      timer:start(1000, 0, function()
        timer:stop()
        timer:close()
        vim.schedule(function()
          callback(adapter)
        end)
      end)
    end
  else
    callback(adapter)
  end
end

local function free_port()
  local tcp = vim.loop.new_tcp()
  tcp:bind("127.0.0.1", 0)
  local port = tcp:getsockname().port
  tcp:shutdown()
  tcp:close()
  return port
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "New instance (current file)",
    port = free_port,
    start_neovim = {},
  },
  {
    type = "nlua",
    request = "attach",
    name = "New instance (dotfiles)",
    port = free_port,
    start_neovim = {
      cwd = os.getenv("HOME"),
      fname = os.getenv("XDG_CONFIG_HOME") .. "/nvim/init.lua",
    },
  },
  {
    type = "nlua",
    request = "attach",
    name = "New instance (neovim/neovim)",
    port = free_port,
    start_neovim = {
      cwd = os.getenv("HOME") .. "/projects/neovim/neovim",
      fname = "src/nvim/main.c",
    },
  },
  {
    type = "nlua",
    request = "attach",
    name = "Attach",
    port = function()
      return assert(tonumber(vim.fn.input("Port: ")), "Port is required")
    end,
  },
}
