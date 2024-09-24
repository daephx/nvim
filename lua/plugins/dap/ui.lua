local dap = require("dap")
local dapui = require("dapui")

local group = vim.api.nvim_create_augroup("DapUIHooks", {})

-- Attempt to focus the terminal buffer on dap session start
-- dap.defaults.fallback.focus_terminal = true

local current_tab = nil
local debug_tab = nil

-- Handle restoring dapui layout
local function resize_debugger()
  if dap.session() then
    dapui.open({ reset = true })
  end
end

-- Jump to the window of specified dapui element
---@param element string filetype of the element
local function jump_to_element(element)
  local visible_wins = vim.api.nvim_tabpage_list_wins(0)
  for _, win in ipairs(visible_wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == element then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.notify(("element '%s' not found"):format(element), vim.log.levels.WARN)
end

-- Close dapui or debugging tab if applicable
local function close_debugger()
  vim.api.nvim_clear_autocmds({ group = group })
  dapui.close()

  -- Return to current tab if they are not the same
  if debug_tab ~= current_tab then
    if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
      local tabnr = vim.api.nvim_tabpage_get_number(debug_tab)
      vim.cmd.tabclose(tabnr)
    end

    local current_win = vim.fn.win_getid()
    if vim.api.nvim_win_get_tabpage(current_win) == current_tab then
      vim.api.nvim_set_current_tabpage(current_tab or 0)
    end
  end

  current_tab = nil
  debug_tab = nil
end

-- Handle opening dapui in separate tab if there are multiple active windows
local function open_debugger()
  if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
    vim.api.nvim_set_current_tabpage(debug_tab)
    return
  end
  local current_win = vim.fn.win_getid()
  current_tab = vim.api.nvim_win_get_tabpage(current_win)

  -- Open current buffer in new tab if tab has multiple windows
  if #vim.api.nvim_tabpage_list_wins(current_tab) > 1 then
    vim.cmd.tabedit("%")
  end

  local debug_win = vim.fn.win_getid()
  debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
  dapui.open({ reset = true })
  jump_to_element("dap-repl")

  vim.api.nvim_create_autocmd({ "VimResized", "WinClosed", "WinEnter", "WinLeave", "WinNew" }, {
    desc = "Create window resizing autocmd",
    group = group,
    callback = resize_debugger,
  })

  vim.api.nvim_create_autocmd({ "ExitPre" }, {
    desc = "Close debug tab on vim exit",
    group = group,
    once = true,
    callback = close_debugger,
  })
end

-- Open dapui event
dap.listeners.after.event_initialized["dapui_config"] = function()
  open_debugger()
end

dap.listeners.before.event_continued["dapui_config"] = function()
  open_debugger()
end

-- Exit dapui event
dap.listeners.before.event_exited["dapui_config"] = function()
  close_debugger()
end

-- Terminate dapui event
dap.listeners.before.event_terminated["dapui_config"] = function()
  close_debugger()
end

-- Center line on breakpoint stopped event
dap.listeners.after.event_stopped["auto_center"] = function()
  vim.api.nvim_create_autocmd("CursorMoved", {
    once = true,
    callback = function()
      vim.cmd.normal("zz")
    end,
  })
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Apply local settings for dapui buffers",
  group = group,
  pattern = "dap*",
  callback = function()
    require("dap.ext.autocompl").attach()
    vim.opt_local.textwidth = 0
  end,
})
