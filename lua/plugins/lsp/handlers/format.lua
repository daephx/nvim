local M = {}

---Store global format toggle state within module.
M.autoformat = true

---Handle formatting formatting notifications.
---@param msg string
local notify = function(msg, level)
  msg = ("[LSP]: %s"):format(msg)
  level = level or vim.log.levels.INFO
  vim.notify(msg, level, { title = "Format" })
end

---Programmatic format control - Always reports state
---@param opts {scope?:'buffer'|'global', state?:boolean}
M.set = function(opts)
  local scope = opts.scope or "global"

  if scope == "buffer" then
    vim.b.autoformat = opts.state
    notify(string.format("Buffer formatting: %s", opts.state and "ENABLED" or "DISABLED"))
  else
    M.autoformat = opts.state ~= false
    if M.autoformat then
      vim.b.autoformat = nil
    end
    notify(string.format("Global formatting: %s", M.autoformat and "ENABLED" or "DISABLED"))
  end
end

---Toggle with explicit state reporting
---@param opts {scope?:'buffer'|'global'}
M.toggle = function(opts)
  local scope = opts.scope or "global"

  if scope == "buffer" then
    vim.b.autoformat = vim.b.autoformat == false and nil or false
    notify(
      string.format("Buffer formatting: %s", vim.b.autoformat == false and "DISABLED" or "ENABLED")
    )
  else
    M.autoformat = not M.autoformat
    if M.autoformat then
      vim.b.autoformat = nil
    end
    notify(string.format("Global formatting: %s", M.autoformat and "ENABLED" or "DISABLED"))
  end
end

---Checks if null-ls has any available formatters for the given filetype.
---@param ft string The filetype to check (e.g., 'lua', 'python').
---@return boolean true if null-ls has formatters for this filetype, false otherwise.
local function ft_has_nls_formatter(ft)
  local ok, sources = pcall(function()
    return require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING")
  end)
  return ok and #sources > 0
end

---Check if formatting should occur based on buffer and global states.
---@param bufnr? integer Buffer number (default: current).
---@return boolean
local function should_format(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return M.autoformat and (vim.b[bufnr].autoformat ~= false)
end

---Formats the current buffer using the preferred LSP formatter.
---Prioritizes null-ls formatters when available, falls back to other LSP clients.
---@param opts? {force: boolean} Command options
M.execute = function(opts)
  opts = opts or {}
  local bufnr = vim.api.nvim_get_current_buf()

  if not opts.force and not should_format(bufnr) then
    local scope = M.autoformat == false and "global" or vim.b.autoformat == false and "buffer" or nil
    return notify(
      string.format("Formatting disabled (%s) (use :Format! to force)", scope),
      vim.log.levels.WARN
    )
  end

  local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  local has_nls_formatter = ft_has_nls_formatter(ft)

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      local is_nls = client.name == "null-ls"
      -- 1. If client is null-ls and has formatter -> use it
      -- 2. If client is not null-ls and null-ls has formatter -> skip it
      -- 3. If null-ls has no formatter -> use any non-null-ls client
      return (is_nls and has_nls_formatter) or (not is_nls and not has_nls_formatter)
    end,
  })
end

---Context-aware command completion
---@return string[]
local function complete_format(_, cmdline, _)
  local partial_args = vim.split(cmdline, "%s+", { trimempty = true })
  local n = #partial_args - 1

  if n == 0 then
    return { "enable", "disable", "toggle" } -- No "format" here
  end

  if n == 1 and vim.tbl_contains({ "enable", "disable", "toggle" }, partial_args[2]) then
    return { "buffer", "global" }
  end

  return {}
end

---Enable document formatting autocmd to trigger on BufWritePre.
---@param client vim.lsp.Client
---@param bufnr integer
M.setup = function(client, bufnr)
  local can_format = client.server_capabilities.documentFormattingProvider
    or client:supports_method("textDocument/formatting")
  if not can_format then
    return
  end

  -- Add user autocmds
  vim.api.nvim_create_user_command("Format", function(opts)
    local args = vim.split(opts.args or "", "%s+", { trimempty = true })

    -- Bare Format or Format! Command
    if #args == 0 then
      return M.execute({ force = opts.bang })
    end

    -- Handle subcommands
    local action = args[1]
    if action == "toggle" then
      M.format_toggle({ scope = args[2] })
    elseif action == "enable" or action == "disable" then
      M.set({ scope = args[2], state = action == "enable" })
    else
      notify("Invalid subcommand. Valid: enable|disable|toggle [buffer|global]", vim.log.levels.ERROR)
    end
  end, {
    bang = true,
    complete = complete_format,
    desc = [[Format document or control formatting:
• Format[!] - Format document (!=force)
• Format enable|disable|toggle [buffer|global]
]],
    nargs = "*",
  })

  -- Add autocmd to handle format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    desc = "Apply Auto-formatting for to document on save",
    group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
    callback = M.execute,
  })
end

return M
