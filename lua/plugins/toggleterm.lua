-- toggleterm.nvim | easily manage multiple terminal windows
-- https://github.com/akinsho/toggleterm.nvim
local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_ok then
  return
end

local function size(term)
  if term.direction == "horizontal" then
    return 20
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.4
  end
end

local function on_open(term)
  local opts = { buffer = term.bufnr, silent = true }
  vim.keymap.set({ "n", "t" }, "<esc><esc>", "<C-\\><C-n>", opts)
end

local function on_close()
  local wins = vim.api.nvim_list_wins()
  if wins == 1 then
    vim.cmd("enew")
  end
end

toggleterm.setup({
  open_mapping = "<C-\\>",
  direction = "horizontal",
  shade_terminals = false,
  size = size,
  on_open = on_open,
  on_close = on_close,
  highlights = {
    Normal = { link = "Normal" },
    FloatBorder = { link = "FloatBorder" },
  },
  float_opts = {
    border = "single",
    width = 190,
    height = 50,
    winblend = 8,
  },
})

--- Terminals ---

-- Export custom terminal settings for different use cases

local Terminal = require("toggleterm.terminal").Terminal

local M = {}

M.lazygit = Terminal:new({
  direction = "float",
  cmd = "lazygit",
  hidden = false,
  on_open = function(term)
    if vim.fn.mapcheck("<esc>", "t") ~= "" then
      vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
    end
  end,
})

M.lazydocker = Terminal:new({
  direction = "float",
  cmd = "lazydocker",
  hidden = false,
  on_open = function(term)
    if vim.fn.mapcheck("<esc>", "t") ~= "" then
      vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<C-\\><C-N>")
    end
  end,
})

_G.toggle_terminal = function(name)
  M[name]:toggle()
end

map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", { desc = "Terminal Tab" })

return M
