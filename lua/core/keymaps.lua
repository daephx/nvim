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

-- General
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })

-- Debug
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Set Breakpoint" })
map("n", "<leader>dn", "<cmd>DapContinue<CR>", { desc = "Continue debugging" })

-- Plugins
map("n", "<leader>pb", "<cmd>Lazy build<CR>", { desc = "Build plugins" })
map("n", "<leader>pc", "<cmd>Lazy clean<CR>", { desc = "Clean plugins" })
map("n", "<leader>ph", "<cmd>Lazy health<CR>", { desc = "Healthcheck plugins" })
map("n", "<leader>pl", "<cmd>Lazy show<CR>", { desc = "Show plugins" })
map("n", "<leader>pm", "<cmd>Mason<CR>", { desc = "Show mason" })
map("n", "<leader>pp", "<cmd>Lazy profile<CR>", { desc = "Profile plugins" })
map("n", "<leader>pr", "<cmd>Lazy restore<CR>", { desc = "Restore plugins" })
map("n", "<leader>ps", "<cmd>Lazy sync<CR>", { desc = "Sync plugins" })
map("n", "<leader>pu", "<cmd>Lazy update<CR>", { desc = "Update plugins" })

-- Git
map("n", "<leader>gG", "<cmd>Neogit<CR>", { desc = "Git Status (Neogit)" })
map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Diff current buffer" })
map("n", "<leader>gg", "<cmd>Gtabedit :<CR>", { desc = "Git Status (Fugitive)" })
map("n", "<leader>gl", "<cmd>GclogTab<CR>", { desc = "Git Log" })

-- New
map("n", "<leader>nt", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>nf", "<cmd>enew<CR>", { desc = "New file" })
