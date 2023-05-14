-- toggleterm.nvim | easily manage multiple terminal windows
-- https://github.com/akinsho/toggleterm.nvim
local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_ok then
  return
end

-- Callback to determine the size of terminal windows
local function size(term)
  if term.direction == "horizontal" then
    return 20
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.4
  end
end

-- Callback to be executed when terminal is opened
local function on_open(term)
  local opts = { buffer = term.bufnr, silent = true }
  vim.keymap.set({ "n", "t" }, "<esc><esc>", "<C-\\><C-n>", opts)
end

-- Callback to be executed when terminal is closed
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

M.bottom_float = Terminal:new({
  direction = "float",
  float_opts = {
    border = { "", "_", "", "", "", "", "", "" },
    anchor = "SW",
    width = vim.o.columns,
    height = function(term)
      local _, zenmode = pcall(function()
        return require("zen-mode.view").is_open()
      end)
      local height = 20
      local cmdheight = vim.o.cmdheight ~= 0 and vim.o.cmdheight or 0
      local statusheight = vim.o.laststatus ~= 0 and 1 or 0
      local botheight = zenmode == true and 0 or cmdheight + statusheight
      term.float_opts.row = vim.o.lines - 1 - height - botheight
      return height
    end,
  },
})

M.tab_float = Terminal:new({
  direction = "float",
  float_opts = {
    border = false,
    width = vim.o.columns,
    height = function(term)
      local cmdheight = vim.o.cmdheight
      local tabline = vim.o.showtabline ~= 0 and 1 or 0
      if vim.o.showtabline == 1 and vim.fn.tabpagenr("$") < 1 then
        tabline = 0
      end
      local statusline = vim.o.laststatus ~= 0 and 1 or 0
      local height = vim.o.lines - cmdheight - tabline - statusline
      term.float_opts.row = 1 + tabline - 2
      return height
    end,
  },
})

M.fullscreen_float = Terminal:new({
  direction = "float",
  float_opts = {
    border = false,
    width = vim.o.columns,
    height = vim.o.lines,
  },
})

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
