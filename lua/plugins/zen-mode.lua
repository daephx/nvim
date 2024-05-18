-- ZenMode | Distraction-free coding for Neovim
-- https://github.com/folke/zen-mode.nvim

local filetypes = {
  "fugitive",
  "log",
}
local buftypes = {
  "nofile",
  "prompt",
  "terminal",
}

local on_open = function(win)
  -- Make certain buffers use all available columns
  local bufnr = vim.api.nvim_win_get_buf(win)
  local bt = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
  local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  if vim.tbl_contains(buftypes, bt) or vim.tbl_contains(filetypes, ft) then
    vim.api.nvim_win_set_width(win, vim.o.columns)
  else
    -- Calculate size based on gutter, textwidth and colorcolumn spacing.
    -- Ensure textwidth is greater than or equal to a minimum of 80 columns.
    local min, max = 80, 120
    local ccol = tonumber(vim.o.colorcolumn:sub(2)) or 0
    local textoff = vim.fn.getwininfo(win)[1].textoff
    local textwidth = vim.bo.textwidth >= min and vim.bo.textwidth or max
    local bufwidth = textwidth + textoff + ccol
    vim.api.nvim_win_set_width(win, bufwidth)
  end
end

---@type LazyPluginSpec
return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<c-w>z", "<cmd>ZenMode<CR>", desc = "Enable ZenMode" },
  },
  opts = {
    backdrop = 1, -- Backdrop shade: Set to 1 to keep the same as Normal.
    -- callback where you can add custom code when the Zen window opens
    on_open = on_open,
  },
}
