-- Neogit | magit for Neovim
-- https://github.com/TimUntersberger/neogit
local neogit_ok, neogit = pcall(require, "neogit")
if not neogit_ok then
  return
end

neogit.setup({
  kind = "tab",
  disable_context_highlighting = true,
  use_magit_keybindings = true,
  integrations = {
    diffview = true, -- Requires you to have `sindrets/diffview.nvim` installed.
  },
  sections = {
    staged = {
      folded = false,
    },
    unstaged = {
      folded = true,
    },
    untracked = {
      folded = true,
    },
    unmerged = {
      folded = false,
    },
    unpulled = {
      folded = true,
    },
    stashes = {
      folded = true,
    },
    recent = {
      folded = false,
    },
  },
  mappings = {
    status = {
      ["B"] = "BranchPopup",
      ["q"] = "Close",
    },
  },
})

--- Highlights ---

local hl = vim.api.nvim_set_hl

hl(0, "NeogitCommitViewHeader", { link = "Constant" })
hl(0, "NeogitDiffContextHighlight", { link = "ColorColumn" })
hl(0, "NeogitHunkHeader", { bg = "none", fg = "#D670D6" })
hl(0, "NeogitObjectId", { bg = "none", fg = "#A056BB" })

--- Autocmds ---

local group = vim.api.nvim_create_augroup("NeogitHooks", {})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Local options to apply to neogit filetypes",
  group = group,
  pattern = "Neogit*",
  callback = function()
    vim.opt_local.spell = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.colorcolumn = "0"
    vim.opt_local.fillchars = { eob = " " }
  end,
})

vim.api.nvim_create_autocmd("User", {
  desc = "Close Neogit after pushing to remote repository",
  group = group,
  pattern = "NeogitPushComplete",
  callback = neogit.close,
})
