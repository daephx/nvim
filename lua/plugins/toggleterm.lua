-- toggleterm.nvim | easily manage multiple terminal windows
-- https://github.com/akinsho/toggleterm.nvim

local terminals = {}

-- Callback to determine the size of terminal windows
---@param term Terminal
---@return integer|nil
local function size(term)
  if term.direction == "horizontal" then
    return vim.o.lines * 0.33
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.5
  end
end

-- Callback to be executed when terminal is opened
---@param term Terminal
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

-- Generate custom terminals from user opts
---@param opts table
local initialize_terminals = function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  -- Process manually defined terminals
  for name, term in pairs(opts.terminals) do
    terminals[name] = Terminal:new(term)
  end
  -- Process basic application terminals
  for _, app in pairs(opts.applications) do
    if vim.fn.executable(app) == 1 then
      local command = app:gsub("^%l", string.upper)
      terminals[app] = Terminal:new({ cmd = app, direction = "float" })
      vim.api.nvim_create_user_command(command, function()
        terminals[app]:toggle()
      end, {})
    end
  end
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<C-\\>" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal (float)" },
    { "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", desc = "Terminal (tab)" },
  },
  -- Terminals exposed in spec for easy access
  terminals = terminals,
  config = function(_, opts)
    require("toggleterm").setup(opts)
    initialize_terminals(opts)

    -- HACK: Terminal buffers that are restored from session don't properly close
    vim.api.nvim_create_autocmd({ "TermClose" }, {
      desc = "Preveent process exited prompt when closing terminal buffer",
      group = vim.api.nvim_create_augroup("ToggleTerm_FixClose", { clear = true }),
      pattern = "term://*;#toggleterm*",
      callback = function(ev)
        if vim.api.nvim_buf_is_loaded(ev.buf) then
          vim.api.nvim_buf_delete(ev.buf, { force = true })
        end
      end,
    })
  end,
  opts = {
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
    -- Commands will be generate to open apps as floating terminals
    applications = {
      "btop",
      "htop",
      "lazydocker",
      "lazygit",
    },
    -- Manually define terminals for more fine tuning
    terminals = {
      fullscreen_float = {
        direction = "float",
        float_opts = {
          border = false,
          width = vim.o.columns,
          height = vim.o.lines,
        },
      },
      tab_float = {
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
      },
      bottom_float = {
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
      },
    },
  },
}
