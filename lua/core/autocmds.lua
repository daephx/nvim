local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd({ "BufEnter", "WinLeave", "FocusLost", "VimSuspend" }, {
  desc = "Leave insert or replace mode on focus loss",
  group = augroup("FocusLostStopInsert", {}),
  pattern = "*",
  command = "if empty(&buftype) | stopinsert | endif",
})

autocmd({ "FocusLost" }, {
  desc = "Write all buffers on FocusLost",
  group = augroup("FocusLostWriteAll", {}),
  command = "silent! wall",
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if any buffers were changed outside of Vim on focus changed",
  group = augroup("UpdateBuffers", {}),
  command = "checktime",
})

autocmd({ "VimResized" }, {
  desc = "Resize splits if vim window is resized",
  group = augroup("ResizeSplits", {}),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

autocmd({ "BufReadPost" }, {
  desc = "Go to last cursor position when opening a buffer",
  group = augroup("LastBufferLocation", {}),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd({ "InsertEnter", "InsertLeave", "TermEnter", "TermLeave" }, {
  desc = "Disable search highlight when entering insert mode",
  group = augroup("ToggleSearchHighlight", {}),
  callback = function(ev)
    if ev.event == "InsertEnter" or ev.event == "TermEnter" then
      vim.b["_lastsearch"] = vim.fn.getreg("/")
      vim.fn.setreg("/", "")
    else
      vim.fn.setreg("/", vim.b["_lastsearch"])
    end
  end,
})

autocmd({ "TextYankPost" }, {
  desc = "Highlight the region on yank",
  group = augroup("HighlightOnYank", {}),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
  end,
})

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  desc = "Intelligent Relative Numbers | Enable",
  group = augroup("SmartHybridNumbers", {}),
  command = "if &nu && mode() != 'i' | set rnu | endif",
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  desc = "Intelligent Relative Numbers | Disable",
  group = "SmartHybridNumbers",
  command = "if &nu | set nornu | endif",
})

autocmd({ "FileType" }, {
  desc = "Prevent auto-insert comment leader on all filetypes",
  group = augroup("NoAutoComment", {}),
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

autocmd({ "FileType" }, {
  desc = "Open vim help pages relative to editor instead of window",
  group = augroup("HelpPageSplit", {}),
  pattern = { "help", "man" },
  command = "wincmd K | resize 20",
})

autocmd({ "BufEnter" }, {
  desc = "Enable lazyredraw for buffers with lots of lines",
  group = augroup("LazyredrawLargeFiles", {}),
  callback = function(ev)
    local limit = 1000
    local count = vim.api.nvim_buf_line_count(ev.buf)
    if count >= limit and vim.o.lazyredraw == false then
      vim.o.lazyredraw = true
    elseif count < limit and vim.o.lazyredraw == true then
      vim.o.lazyredraw = false
    end
  end,
})

autocmd({ "FileType" }, {
  desc = "Apply 'q' keymap to close local buffers that match criteria",
  group = augroup("QuickClose", {}),
  pattern = { "*", "!term://*", "!dap*" },
  callback = function(ev)
    local is_eligible = vim.bo.buftype ~= ""
      or not vim.bo.modifiable
      or vim.bo.readonly
      or vim.wo.previewwindow
    if is_eligible then
      vim.bo[ev.buf].buflisted = false
      local opts = { buffer = ev.buf, silent = true }
      vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
    end
  end,
})

autocmd({ "BufNewFile" }, {
  desc = "Inject Skeleton template when creating new file",
  group = augroup("SkeletonTemplate", {}),
  pattern = "*",
  callback = function()
    local path = vim.fn.stdpath("config")
    local fname = vim.fn.expand("<afile>:e") .. ".skel"
    vim.cmd(("silent! execute '0r %s/templates/skel/%s'"):format(path, fname))
  end,
})
