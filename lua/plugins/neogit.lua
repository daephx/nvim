-- Neogit | magit for Neovim
-- https://github.com/TimUntersberger/neogit
---@module "neogit"

---@type LazySpec
return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  dependencies = {
    -- Collection of useful lua functions
    { "nvim-lua/plenary.nvim" },
    -- Easily cycling through diffs
    { "sindrets/diffview.nvim" },
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Git Status" },
  },
  ---@type NeogitConfig
  opts = {
    kind = "tab",
    disable_context_highlighting = true,
    process_spinner = false,
    integrations = {
      diffview = true,
      telescope = true,
    },
    popup = { kind = "split" },
    commit_popup = { kind = "split_above" },
    mappings = {
      commit_editor = {
        ["q"] = false,
      },
      rebase_editor = {
        ["d"] = false,
        ["e"] = false,
        ["f"] = false,
        ["p"] = false,
        ["r"] = false,
        ["s"] = false,
        ["x"] = false,
      },
    },
  },
  init = function()
    -- Alias command `Neogit` to `Git`
    vim.api.nvim_create_user_command("Git", function(o)
      local neogit = require("neogit")
      neogit.open(require("neogit.lib.util").parse_command_args(o.fargs))
    end, {
      nargs = "*",
      desc = "Open Neogit",
      complete = function(arglead)
        local neogit = require("neogit")
        return neogit.complete(arglead)
      end,
    })

    -- Set default highlights
    local colors = require("config.colors")
    colors.set_hl_autocmd(nil, {
      DiffviewFilePanelDeletions = { link = "Removed", default = true },
      DiffviewFilePanelInsertions = { link = "Added", default = true },
      NeogitCommitViewDescription = { link = "Normal", default = true },
      NeogitDiffAdditions = { link = "Added", default = true },
      NeogitDiffDeletions = { link = "Removed", default = true },
      NeogitObjectId = { link = "Structure", default = true },
    })

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Local options to apply to neogit filetypes",
      group = vim.api.nvim_create_augroup("NeogitBuffer#OptionOverride", {}),
      pattern = "Neogit*",
      callback = function()
        vim.opt_local.colorcolumn = "0"
        vim.opt_local.spell = false
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Prevent status buffers from over-scrolling",
      group = vim.api.nvim_create_augroup("NeogitStatus#OptionOverride", {}),
      pattern = { "NeogitPopup", "NeogitStatus" },
      callback = function()
        vim.opt_local.scrolloff = 999
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      desc = "Close Neogit after pushing to remote repository",
      group = vim.api.nvim_create_augroup("NeogitPush#AutoClose", {}),
      pattern = "NeogitPushComplete",
      callback = function()
        require("neogit").close()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Set filetype back to gitcommit for NeogitCommitMessage buffer",
      group = vim.api.nvim_create_augroup("NeogitCommitMessage#FileTypeOverride", {}),
      pattern = "NeogitCommitMessage",
      command = "silent! set filetype=gitcommit",
    })

    -- NOTE: Cannot disable `q` in plugin options due to inherited mappings from
    -- `status`, which would prevent closing the status buffer with `q`.
    vim.api.nvim_create_autocmd("WinEnter", {
      desc = "Disable 'q' mapping in NeogitDiffView to prevent accidental closure",
      group = vim.api.nvim_create_augroup("NeogitStagedDiff#KeymapOverride", {}),
      callback = function(ev)
        if vim.bo[ev.buf].filetype == "NeogitDiffView" then
          vim.keymap.set("n", "q", "<nop>", { buffer = ev.buf, remap = true })
        end
      end,
    })
  end,
}
