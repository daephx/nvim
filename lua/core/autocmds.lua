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

augroup("DisableSearchHighlight", {})
autocmd({ "InsertEnter", "WinLeave" }, {
  desc = "Disable search highlight when entering insert mode",
  group = "DisableSearchHighlight",
  command = "nohlsearch",
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

augroup("MakeParentDirectory", {})
autocmd("BufWritePre", {
  desc = "Create parent directory when writing file if path does not exist",
  group = "MakeParentDirectory",
  callback = function(opts)
    local buftype = vim.api.nvim_buf_get_option(opts.buf, "buftype")
    local buf_empty = vim.fn.empty(buftype) == 1
    local dir_path = vim.fn.fnamemodify(opts.file, ":p:h")
    local dir_exists = vim.fn.isdirectory(dir_path) == 1
    local dir_remote = dir_path:find("%l+://") == 1
    if buf_empty or dir_exists or dir_remote then
      return
    end
    local msg = 'Parent path doesn\'t exist: "%s"\r\nCreate file path? [y/N]: '
    local prompt = string.format(msg, opts.file)
    vim.ui.input({
      prompt = prompt,
    }, function(input)
      if input == "y" then
        vim.fn.mkdir(dir_path, "p")
      end
    end)
  end,
})

augroup("TerminalBuffers", {})
autocmd("TermOpen", {
  desc = "",
  group = "TerminalBuffers",
  pattern = "term://*",
  callback = function()
    vim.opt_local.buflisted = true
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
    vim.opt_local.scrolloff = 0
    vim.opt_local.winfixheight = true
  end,
})

autocmd("TermClose", {
  desc = "Skip prompt, Automatically close exited terminal buffer processes",
  group = "TerminalBuffers",
  pattern = "term://*",
  callback = function()
    vim.fn.feedkeys("i")
    vim.api.nvim_input("<esc>")
  end,
})

autocmd({ "TermOpen", "BufEnter" }, {
  desc = "Automatically enter insert mode when focusing a terminal buffer",
  group = "TerminalBuffers",
  pattern = "term://*",
  command = "startinsert",
})

autocmd({ "TermClose", "BufLeave" }, {
  desc = "Disable insert mode when leaving a terminal buffer",
  group = "TerminalBuffers",
  pattern = "term://*",
  command = "stopinsert",
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
