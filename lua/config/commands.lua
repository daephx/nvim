-- Command-line utilities: user commands and abbreviations

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

---@param args vim.api.keyset.create_user_command.command_args
local toggle_inlay_hints = function(args)
  local current = vim.lsp.inlay_hint.is_enabled()
  local arg = (args.args ~= "" and args.args or "toggle"):lower()
  local state = ({ enable = true, disable = false, toggle = not current })[arg]

  if state == nil then
    return vim.notify("Invalid argument: " .. arg, vim.log.levels.WARN)
  end

  if state ~= current then
    vim.lsp.inlay_hint.enable(state)
    vim.notify("Inlay hints " .. (state and "enabled" or "disabled"))
  end
end

-- User command to enable, disable, or toggle LSP inlay hints
vim.api.nvim_create_user_command("InlayHints", toggle_inlay_hints, {
  complete = function()
    return { "enable", "disable", "toggle" }
  end,
  nargs = "?",
})

-- Define command-line abbreviations for common case-sensitive typos and shortcuts
local abbrevs = {
  -- Delete buffer
  { "BD", "bd" },
  { "Bd", "bd" },
  { "bD", "bd" },

  -- Edit file
  { "E", "e" },

  -- Source file
  { "SO", "so" },
  { "So", "so" },
  { "sO", "so" },

  -- Quit
  { "Q", "q" },
  -- Quit all
  { "QA", "qa" },
  { "Qa", "qa" },
  { "qA", "qa" },

  -- Source file
  { "SO", "so" },
  { "So", "so" },
  { "sO", "so" },

  -- Write file
  { "W", "w" },
  -- Write and quit
  { "WQ", "wq" },
  { "Wq", "wq" },
  { "wQ", "wq" },

  -- Exit
  { "X", "x" },
  -- Exit all
  { "XA", "xa" },
  { "Xa", "xa" },
  { "xA", "xa" },

  -- Sort lines
  { "Sort", "sort" },
  -- Remove duplicate lines
  { "Uniq", "uniq" },

  -- Delete current buffer without closing window
  { "bdd", "bn|bd#" },
}

-- Apply all abbreviations
for _, abbr in ipairs(abbrevs) do
  vim.cmd.cnoreabbrev(abbr)
end
