--     __ __
--    / //_/__  __  ______ ___  ____ _____  _____
--   / ,< / _ \/ / / / __ `__ \/ __ `/ __ \/ ___/
--  / /| /  __/ /_/ / / / / / / /_/ / /_/ (__  )
-- /_/ |_\___/\__, /_/ /_/ /_/\__,_/ .___/____/
-- ========= /____/ ============= /_/ ========
-- General neovim keyboard mapping definitions

-- Easier mapping function
function map(mode, lhs, rhs, opts)
  local defaults = { remap = false, silent = true }
  opts = vim.tbl_extend("force", defaults, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Visually move lines <Up/Down>
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")

map("v", "<A-Up>", ":m '<-2<CR>gv=gv")
map("v", "<A-Down>", ":m '>+1<CR>gv=gv")

-- Make Y act like other capitals
map("n", "Y", "y$")

-- Prevent <Delete> from yanking
map("v", "<del>", '"_d')

-- Banish Q to the shadow realm
map("n", "Q", "<nop>")

-- Ctrl-Z undo in insert
map("i", "<c-z>", "<c-o>:u<CR>")

-- Remove highlight after search with ESCAPE
map("n", "<esc>", ":nohlsearch<cr><esc>")

-- Jumplist center cursor
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

-- Keep incsearch in center of buffer
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Prevent jump when search under cursor
map("n", "*", "*N")

-- Visual indentation
map("v", "<", "<gv")
map("v", ">", ">gv")

map("v", "<S-Tab>", "<gv")
map("v", "<Tab>", ">gv")

-- Navigate buffer
map("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", ":bnext<CR>", { desc = "Next buffer" })

-- Delete active buffer in window
map("n", "<c-w>d", "<cmd>bn|bd#<CR>")

-- General save document
map({ "i", "n" }, "<c-s>", "<cmd>write<CR>")

-- Create new buffers/tabs
map("n", "<leader>nt", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>nf", "<cmd>enew<CR>", { desc = "New file" })
