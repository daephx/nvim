-- Module: mappings
-- Description: Define key mappings for lua config

local api = vim.api

--- Mappings ---

-- Visually move lines <Up/Down>
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Make Y act like other capitals
map("n", "Y", "y$")

-- Black hole Registers
-- Breaks default functionality
map("v", "<del>", '"_d') -- Prevent <Delete> from yanking

-- Remove highlight after search with ESCAPE
map("n", "<esc>", ":nohlsearch<cr><esc>")

-- Ctrl - hjkl to navigate splits
map("n", "<c-h>", "<cmd>wincmd h<CR>")
map("n", "<c-j>", "<cmd>wincmd j<CR>")
map("n", "<c-k>", "<cmd>wincmd k<CR>")
map("n", "<c-l>", "<cmd>wincmd l<CR>")

-- Visual indentation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Formatting
-- TODO: Better formatting, check if lsp attachedm else rely on cmd / formatter.nvim
map("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>") -- Activate LSP buffer formatter

-- Quickfix
map("n", "<c-q>", "<cmd>call ToggleQFList(1)<CR>")
map("n", "<localleader>q", "<cmd>call ToggleQFList(1)<CR>")
map("n", "<c-k>", "<cmd>cprev<CR>zz")
map("n", "<c-j>", "<cmd>cnext<CR>zz")

-- General
map("n", "<leader><Space>", "<cmd>Telescope buffers<CR>", { desc = "Open Buffers" })
map("n", "<leader>/", "<Plug>kommentary_line_default", { desc = "Comment Line" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })

-- Debug Protocol
map("n", "<leader>db", '<cmd>lua require("dap").toggle_breakpoint()<CR>', { desc = "Set Breakpoint" })
map(
  "n",
  "<leader>dd",
  '<cmd>lua require("dap.python").attach_python_debugger()<CR>',
  { desc = "Start Debugging" }
)
map("n", "<leader>dn", '<cmd>lua require("dap").continue()<CR>', { desc = "Continue debugging" })

-- Telescope Find
map(
  "n",
  "<leader>f.",
  '<cmd>lua require("plugins.telescope").search_dotfiles()<CR>',
  { desc = "Dotfiles" }
)
map("n", "<leader>f<S-c>", "<cmd>Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>f<S-f>", "<cmd>Telescope treesitter<CR>", { desc = "Treesitter" })
map("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Grep Buffer" })
map("n", "<leader>fc", "<cmd>Telescope colorscheme<CR>", { desc = "ColorSchemes" })
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
map(
  "n",
  "<leader>fw",
  '<cmd>lua require("plugins.telescope").search_wikifiles()<CR>',
  { desc = "Wiki" }
)

-- Plugins
map("n", "<leader>ps", "<cmd>Lazy show<CR>", { desc = "Plugins status" })
map("n", "<leader>pu", "<cmd>Lazy update<CR>", { desc = "Update Plugins" })

-- Git
map("n", "<leader>gG", '<cmd>lua require("neogit").open()<CR>', { desc = "Git Status (Neogit)" })
map(
  "n",
  "<leader>gb",
  '<cmd>lua require("plugins.telescope").git_branches()<CR>',
  { desc = "Git branches" }
)
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
