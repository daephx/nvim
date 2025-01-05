-- toggleterm.nvim | easily manage multiple terminal windows
-- https://github.com/akinsho/toggleterm.nvim
---@module "toggleterm"

---List of custom terminal configurations.
---@type Terminal[]
local terminals = {}

---Callback to determine the size of terminal windows.
---@param term Terminal
---@return integer|nil
local function size(term)
  if term.direction == "horizontal" then
    return vim.o.lines * 0.33
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.5
  end
end

---Callback to be executed when terminal is opened.
---@param term Terminal
local function on_open(term)
  local opts = { buffer = term.bufnr, silent = true }
  vim.keymap.set({ "n", "t" }, "<esc><esc>", "<C-\\><C-n>", opts)
end

---Callback to be executed when terminal is closed.
local function on_close()
  local wins = vim.api.nvim_list_wins()
  if wins == 1 then
    vim.cmd("enew")
  end
end

---Generate custom terminals from user opts.
---@param executables string[]
local initialize_terminals = function(executables)
  local Terminal = require("toggleterm.terminal").Terminal
  for _, app in pairs(executables) do
    if vim.fn.executable(app) == 1 then
      local command = app:gsub("^%l", string.upper)
      terminals[app] = Terminal:new({ cmd = app, direction = "float" })
      vim.api.nvim_create_user_command(command, function()
        terminals[app]:toggle()
      end, {})
    end
  end
end

---Commands will be generate to open apps as floating terminals.
local executables = {
  "btop",
  "htop",
  "ipython",
  "lazydocker",
  "lazygit",
  "node",
  "python",
}

---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  event = { "VeryLazy" },
  keys = {
    { "<C-\\>" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal (float)" },
    { "<leader>ts", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal (split)" },
    { "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", desc = "Terminal (tab)" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Terminal (vsplit)" },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    initialize_terminals(executables)
  end,
  opts = {
    open_mapping = "<C-\\>",
    close_on_exit = true,
    direction = "float",
    shade_terminals = false,
    size = size,
    on_open = on_open,
    on_close = on_close,
    highlights = {
      Normal = { link = "Normal" },
      NormalFloat = { link = "NormalFloat" },
      FloatBorder = { link = "FloatBorder" },
    },
  },
}
