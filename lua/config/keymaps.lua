-- General neovim keyboard mapping definitions
local util = require("config.util")

local defaults = { remap = false, silent = true }
util.register_keymaps(defaults, {
  -- Visually move lines <Up/Down>
  { "v", "<A-k>", ":m '<-2<CR>gv=gv" },
  { "v", "<A-j>", ":m '>+1<CR>gv=gv" },
  { "v", "<A-Up>", ":m '<-2<CR>gv=gv" },
  { "v", "<A-Down>", ":m '>+1<CR>gv=gv" },

  -- Make Y act like other capitals
  { "n", "Y", "y$" },

  -- Prevent <Delete> from yanking
  { "v", "<del>", '"_d' },

  -- Banish Q to the shadow realm
  { "n", "Q", "<nop>" },

  -- Ctrl-Z undo in insert
  { "i", "<c-z>", "<c-o>:u<CR>" },

  -- Remove highlight after search with ESCAPE
  { "n", "<esc>", "<cmd>nohlsearch<cr><esc>" },

  -- Jumplist center cursor
  { "n", "<C-o>", "<C-o>zz" },
  { "n", "<C-i>", "<C-i>zz" },

  -- Keep incsearch in center of buffer
  { "n", "n", "nzzzv" },
  { "n", "N", "Nzzzv" },

  -- Prevent jump when search under cursor
  { "n", "*", "*N" },

  -- Search for visually highlighted text
  { "v", "*", 'y<ESC>/<c-r>"<CR>N' },

  -- Visual indentation
  { "v", "<", "<gv" },
  { "v", ">", ">gv" },
  { "v", "<S-Tab>", "<gv" },
  { "v", "<Tab>", ">gv" },

  -- Navigate buffer
  { "n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" } },
  { "n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" } },

  -- Delete active buffer in window
  { "n", "<c-w>d", "<cmd>bn|bd#<CR>" },

  -- General save document
  { { "i", "n" }, "<c-s>", "<cmd>write<CR>" },

  -- Create new buffers/tabs
  { "n", "<leader>nt", "<cmd>tabnew<CR>", { desc = "New tab" } },
  { "n", "<leader>nf", "<cmd>enew<CR>", { desc = "New file" } },
})
