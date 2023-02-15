local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("FocusIssues", {})
autocmd({ "BufEnter", "WinLeave", "FocusLost", "VimSuspend" }, {
  desc = "Leave insert or replace mode on focus loss",
  group = "FocusIssues",
  pattern = "*",
  command = "if empty(&buftype) | stopinsert | endif",
})

autocmd({ "FocusLost" }, {
  desc = "Write all buffers on FocusLost",
  group = "FocusIssues",
  command = "silent! wall ",
})

autocmd({ "CursorHold", "CursorHoldI" }, {
  desc = "Update current buffer on CursorHold/I",
  group = "FocusIssues",
  command = "silent! update",
})

augroup("ToggleSearchHighlight", { clear = true })
autocmd({ "InsertEnter", "InsertLeave", "TermEnter", "TermLeave" }, {
  desc = "Disable search highlight when entering insert mode",
  group = "ToggleSearchHighlight",
  callback = function(opts)
    if opts.event == "InsertEnter" or opts.event == "TermEnter" then
      vim.b["_lastsearch"] = vim.fn.getreg("/")
      vim.fn.setreg("/", "")
    else
      vim.fn.setreg("/", vim.b["_lastsearch"])
    end
  end,
})

augroup("YankHighlight", {})
autocmd("TextYankPost", {
  desc = "Highlight the region on yank",
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
  end,
})

augroup("SmartHybridNumbers", {})
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  desc = "Intelligent Relative Numbers | Enable",
  group = "SmartHybridNumbers",
  command = 'if &nu && mode() != "i" | set rnu | endif',
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  desc = "Intelligent Relative Numbers | Disable",
  group = "SmartHybridNumbers",
  command = "if &nu | set nornu | endif",
})

augroup("NoAutoComment", {})
autocmd({ "FileType" }, {
  desc = "Prevent auto-insert comment leader on all filetypes",
  group = "NoAutoComment",
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

augroup("HelpPageSplit", {})
autocmd("FileType", {
  desc = "Open vim help pages relative to editor instead of window",
  group = "HelpPageSplit",
  pattern = { "help", "man" },
  command = "wincmd K",
})

augroup("QuickClose", {})
autocmd("FileType", {
  desc = 'Apply "q" keymap to close local buffers that match criteria',
  group = "QuickClose",
  pattern = { "*", "!term://*", "!dap*" },
  callback = function(opts)
    local is_eligible = vim.bo.buftype ~= ""
      or not vim.bo.modifiable
      or vim.bo.readonly
      or vim.wo.previewwindow
    if is_eligible then
      local options = { buffer = opts.buf, remap = false, silent = true }
      vim.keymap.set("n", "q", "<cmd>close<CR>", options)
    end
  end,
})

augroup("MkDirectory", { clear = true })
autocmd("BufWritePre", {
  desc = "Create parent directory when writing file if path does not exist",
  group = "MkDirectory",
  callback = function(opts)
    local folder = vim.fn.fnamemodify(opts.file, ":p:h")
    local buftype = vim.api.nvim_buf_get_option(opts.buf, "buftype")
    local empty = vim.fn.empty(buftype) == 1
    local exists = vim.fn.isdirectory(folder) == 1
    local remote = folder:find("%l+://") == 1
    if empty and not exists and not remote then
      vim.fn.mkdir(folder, "p")
    end
  end,
})

augroup("SkeletonTemplate", {})
autocmd("BufNewFile", {
  desc = "Inject Skeleton template when creating new file",
  group = "SkeletonTemplate",
  pattern = "*",
  callback = function()
    vim.cmd(
      "silent! execute '0r "
        .. vim.fn.stdpath("config")
        .. "/templates/skel/skeleton.'.expand('<afile>:e')"
    )
  end,
})
