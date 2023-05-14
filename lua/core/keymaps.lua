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
map("n", "<leader><Space>", "<cmd>Telescope buffers<CR>", { desc = "Open Buffers" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })

-- Debug
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Set Breakpoint" })
map("n", "<leader>dn", "<cmd>DapContinue<CR>", { desc = "Continue debugging" })

-- Fuzzy
map(
  "n",
  "<leader>f.",
  '<cmd>lua require("plugins.telescope").search_dotfiles()<CR>',
  { desc = "Dotfiles" }
)
map("n", "<leader>fC", "<cmd>Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>fF", "<cmd>Telescope treesitter<CR>", { desc = "Treesitter" })
map("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Grep Buffer" })
map("n", "<leader>fc", "<cmd>Telescope colorscheme<CR>", { desc = "Colorschemes" })
map("n", "<leader>fd", "<cmd>Telescope lsp_document_diagnostics<CR>", { desc = "LSP Diagnostics" })
map("n", "<leader>fe", "<cmd>Telescope file_browser<CR>", { desc = "File Explorer" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Current Files" })
map("n", "<leader>fh", "<cmd>Telescope highlights<CR>", { desc = "Highlight Groups" })
map("n", "<leader>fl", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Bookmarks" })
map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Project list" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files" })
map("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { desc = "Grep String" })
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Search Todo comments" })
map(
  "n",
  "<leader>fv",
  '<cmd>lua require("plugins.telescope").search_vimfiles()<CR>',
  { desc = "VimRC" }
)

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
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Diff current buffer" })
map("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "Git files" })
map("n", "<leader>gg", "<cmd>Gtabedit :<CR>", { desc = "Git Status (Fugitive)" })
map("n", "<leader>gl", "<cmd>GclogTab<CR>", { desc = "Git Log" })
map(
  "n",
  "<leader>gz",
  '<cmd>lua require("plugins.toggleterm").lazygit:toggle()<CR>',
  { desc = "Lazygit" }
)

-- New
map("n", "<leader>nt", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>nf", "<cmd>enew<CR>", { desc = "New file" })

-- Terminal
map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", { desc = "Terminal Tab" })
map(
  "n",
  "<leader>td",
  '<cmd>lua require("plugins.toggleterm").lazydocker:toggle()<CR>',
  { desc = "Lazydocker" }
)
map(
  "n",
  "<leader>tg",
  '<cmd>lua require("plugins.toggleterm").lazygit:toggle()<CR>',
  { desc = "Lazygit" }
)
