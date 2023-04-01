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
  command = "wincmd K",
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

autocmd({ "BufWritePre" }, {
  desc = "Create parent directory when writing file if path does not exist",
  group = augroup("MkDirectory", {}),
  callback = function(ev)
    local folder = vim.fn.fnamemodify(ev.file, ":p:h")
    local buftype = vim.api.nvim_buf_get_option(ev.buf, "buftype")
    local empty = vim.fn.empty(buftype) == 1
    local exists = vim.fn.isdirectory(folder) == 1
    local remote = folder:find("%l+://") == 1
    if empty and not exists and not remote then
      vim.fn.mkdir(folder, "p")
    end
  end,
})

autocmd({ "BufNewFile" }, {
  desc = "Inject Skeleton template when creating new file",
  group = augroup("SkeletonTemplate", {}),
  pattern = "*",
  callback = function()
    vim.cmd(
      "silent! execute '0r "
        .. vim.fn.stdpath("config")
        .. "/templates/skel/skeleton.'.expand('<afile>:e')"
    )
  end,
})
