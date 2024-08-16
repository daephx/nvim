-- Commands

-- Typo commands
vim.cmd.cnoreabbrev({ "BD", "bd" })
vim.cmd.cnoreabbrev({ "Bd", "bd" })
vim.cmd.cnoreabbrev({ "bD", "bd" })

vim.cmd.cnoreabbrev({ "E", "e" })

vim.cmd.cnoreabbrev({ "SO", "so" })
vim.cmd.cnoreabbrev({ "So", "so" })
vim.cmd.cnoreabbrev({ "sO", "so" })

vim.cmd.cnoreabbrev({ "Q", "q" })
vim.cmd.cnoreabbrev({ "QA", "qa" })
vim.cmd.cnoreabbrev({ "Qa", "qa" })
vim.cmd.cnoreabbrev({ "qA", "qa" })

vim.cmd.cnoreabbrev({ "SO", "so" })
vim.cmd.cnoreabbrev({ "So", "so" })
vim.cmd.cnoreabbrev({ "sO", "so" })

vim.cmd.cnoreabbrev({ "W", "w" })
vim.cmd.cnoreabbrev({ "WQ", "wq" })
vim.cmd.cnoreabbrev({ "Wq", "wq" })
vim.cmd.cnoreabbrev({ "wQ", "wq" })

vim.cmd.cnoreabbrev({ "X", "x" })
vim.cmd.cnoreabbrev({ "XA", "xa" })
vim.cmd.cnoreabbrev({ "Xa", "xa" })
vim.cmd.cnoreabbrev({ "xA", "xa" })

-- Delete buffer without closing window
vim.cmd.cnoreabbrev({ "bdd", "bn|bd#" })

---Load or reload a Lua module in the current Neovim session
---@param name string Path to the Lua file
---@return any
local reload_module = function(name)
  if package.loaded["plenary"] then
    require("plenary.reload").reload_module(name, true)
  else
    package.loaded[name] = nil
  end
  return require(name)
end

---Handle the reload command by parsing the module name
---@param ctx table Context containing the command arguments
local function reload_command_handler(ctx)
  local name = ctx.args
  if name == "" then
    name = vim.fn.expand("%:.")
    name = name:gsub("%.lua", "")
    name = name:gsub("lua[/|\\]", "")
  end
  print(("Reloading module: %s"):format(name))
  reload_module(name)
end

---Provide completion options for the reload command
---@return table
local reload_command_completion = function()
  local modules = {}
  for key, _ in pairs(package.loaded) do
    table.insert(modules, key)
  end
  return modules
end

-- Register commands: Reload
vim.cmd.cnoreabbrev({ "R", "Reload" })
vim.api.nvim_create_user_command("Reload", reload_command_handler, {
  complete = reload_command_completion,
  nargs = "?",
})

---Redirect the output of a command to a new buffer
---@param ctx table
local redirect_output = function(ctx)
  local exec = vim.api.nvim_exec2(ctx.args, { output = true })
  local lines = vim.split(exec.output, "\n", { plain = true })
  vim.cmd.new()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.spell = false
  vim.opt_local.modified = false
end

-- Register commands: Redir
vim.api.nvim_create_user_command("Redir", redirect_output, {
  complete = "command",
  nargs = "+",
})
