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
})

--- Keymaps ---

map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", { desc = "Terminal Tab" })

--- Terminals ---

-- Export custom terminal settings for different use cases

local Terminal = require("toggleterm.terminal").Terminal

local M = {}

local applications = {
  "btop",
  "htop",
  "lazydocker",
  "lazygit",
}

local init_command_terminals = function()
  for _, app in pairs(applications) do
    if vim.fn.executable(app) then
      M[app] = Terminal:new({ cmd = app, direction = "float" })
      local command = app:gsub("^%l", string.upper)
      vim.api.nvim_create_user_command(command, function()
        M[app]:toggle()
      end, {})
    end
  end
end

init_command_terminals()

return M
