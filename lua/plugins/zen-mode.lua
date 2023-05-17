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
  local bt = vim.api.nvim_buf_get_option(bufnr, "buftype")
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if vim.tbl_contains(buftypes, bt) or vim.tbl_contains(filetypes, ft) then
    vim.api.nvim_win_set_width(win, vim.o.columns)
  else
    -- Calculate size based on gutter, textwidth and colorcolumn spacing
    local ccol = tonumber(vim.o.colorcolumn:sub(2)) or 0
    local textoff = vim.fn.getwininfo(win)[1].textoff
    local width = vim.o.textwidth + textoff + ccol
    vim.api.nvim_win_set_width(win, width)
  end
end

return {
  "folke/zen-mode.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<c-w>z", "<cmd>ZenMode<CR>", desc = "Enable ZenMode" },
  },
  opts = {
    backdrop = 1, -- Backdrop shade: Set to 1 to keep the same as Normal.
    -- callback where you can add custom code when the Zen window opens
    on_open = on_open,
  },
}
