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

---Return "ENABLED" if state is true, otherwise "DISABLED".
---@param state boolean
---@return string
local format_state = function(state)
  return state and "Enabled" or "Disabled"
end

---Check if formatting should occur based on buffer and global states.
---@param bufnr? integer Buffer number (default: current).
---@return boolean
local should_format = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return M.autoformat and (vim.b[bufnr].autoformat ~= false)
end

---Check for configured formatters within null-ls
---@return boolean
local should_use_nls = function(bufnr)
  local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  local nls_ok, has_formatter = pcall(function()
    return #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
  end)
  return nls_ok and has_formatter
end

---Check for configured formatters within efm
---@return boolean
local should_use_efm = function(bufnr)
  local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "efm" })
  if #clients > 0 then
    local langs = vim.tbl_get(clients[1], "config", "settings", "languages")
      or vim.tbl_get(clients[1], "settings", "languages")
      or {}
    for _, t in ipairs(langs[ft] or {}) do
      if t["formatCommand"] then
        return true
      end
    end
  end
  return false
end

---Context-aware command completion
---@return string[]
local complete_format = function(_, cmdline, _)
  local partial_args = vim.split(cmdline, "%s+", { trimempty = true })
  local n = #partial_args - 1
  local subcommands = { "enable", "disable", "toggle" }
  local scopes = { "buffer", "global" }

  if n == 0 then
    return subcommands
  end
  if n == 1 and vim.tbl_contains(subcommands, partial_args[2]) then
    return scopes
  end

  return {}
end

---Programmatic format control - Always reports state
---@param opts {scope?:'buffer'|'global', state?:boolean}
M.set = function(opts)
  local scope = opts.scope or "global"

  if scope == "buffer" then
    vim.b.autoformat = opts.state
    notify(("Buffer formatting: %s"):format(format_state(opts.state)))
  else
    M.autoformat = opts.state ~= false
    if M.autoformat then
      vim.b.autoformat = nil
    end
    notify(("Global formatting: %s"):format(format_state(M.autoformat)))
  end
end

---Toggle with explicit state reporting
---@param opts {scope?:'buffer'|'global'}
M.toggle = function(opts)
  local scope = opts.scope or "global"

  if scope == "buffer" then
    vim.b.autoformat = vim.b.autoformat == false and nil or false
    notify(("Buffer formatting: %s"):format(format_state(vim.b.autoformat == false)))
  else
    M.autoformat = not M.autoformat
    if M.autoformat then
      vim.b.autoformat = nil
    end
    notify(("Global formatting: %s"):format(format_state(M.autoformat)))
  end
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

  -- Check special format providers
  local has_nls = should_use_nls(bufnr)
  local has_efm = should_use_efm(bufnr)

  -- Call the formatter
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      if has_nls then
        return client.name == "null-ls"
      elseif has_efm then
        return client.name == "efm"
      else
        return true
      end
    end,
  })
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

  -- Register Format[!] user command
  vim.api.nvim_create_user_command("Format", function(opts)
    local args = vim.split(opts.args or "", "%s+", { trimempty = true })

    -- Simply execute if no arguments are provided
    if #args == 0 then
      return M.execute({ force = opts.bang })
    end

    -- Handle subcommands
    local action = args[1]
    if action == "toggle" then
      M.toggle({ scope = args[2] })
    elseif action == "enable" or action == "disable" then
      M.set({ scope = args[2], state = action == "enable" })
    else
      notify("Invalid argument. Valid: enable|disable|toggle [buffer|global]", vim.log.levels.ERROR)
    end
  end, {
    bang = true,
    complete = complete_format,
    desc = [[Format document or control formatting:
• Format[!] - Format current document
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
