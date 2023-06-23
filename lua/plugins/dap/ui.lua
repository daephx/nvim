local dap = require("dap")
local dapui = require("dapui")

local group = vim.api.nvim_create_augroup("DapUIHooks", {})

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

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
  jump_to_element("dap-repl")
end

dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
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
