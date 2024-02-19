-- Improve terminal buffers with autocmds and options

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group = augroup("Term#Options", { clear = true })

local set_terminal_options = function()
  vim.opt_local.spell = false
  vim.opt_local.buflisted = false
  vim.opt_local.list = false
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.cursorline = false
  vim.opt_local.scrolloff = 0
  vim.opt_local.sidescrolloff = 0
  vim.opt_local.signcolumn = "no"
  vim.opt_local.winfixheight = true
  vim.opt_local.fillchars = { eob = " " }
end

local set_terminal_keymaps = function()
  local opts = { buffer = 0, remap = false, silent = true }
  vim.keymap.set("t", "<C-PageDown>", "<C-\\><C-n><C-PageDown>", opts)
  vim.keymap.set("t", "<C-PageUp>", "<C-\\><C-n><C-PageUp>", opts)
  vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>", opts)
  vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", opts)
end

autocmd({ "TermOpen" }, {
  desc = "Apply local options to terminal buffers",
  group = group,
  pattern = "term://*",
  callback = function()
    set_terminal_options()
    set_terminal_keymaps()
  end,
})

autocmd({ "TermOpen", "BufEnter" }, {
  desc = "Enter insert mode when focusing a terminal buffer",
  group = group,
  pattern = "term://*",
  callback = vim.schedule_wrap(function(ev)
    local curbuf = vim.api.nvim_win_get_buf(0)
    if curbuf == ev.buf then
      vim.cmd.startinsert()
    end
  end),
})

autocmd({ "TermClose", "BufLeave" }, {
  desc = "Exit insert mode when leaving a terminal buffer",
  group = group,
  pattern = "term://*",
  command = "stopinsert",
})
