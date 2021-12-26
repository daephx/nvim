-- Neogit | magit for NeoVim

-- Prevent loading if not applicable
local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

neogit.setup {
  kind = { 'tab' },
  auto_refresh = true,
  disable_signs = false,
  disable_context_highlighting = true,
  disable_commit_confirmation = false,
  disable_builtin_notifications = false,
  use_magit_keybindings = true,
  commit_popup = { kind = 'split' },
  integrations = {
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
    -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
    diffview = true -- Requires you to have `sindrets/diffview.nvim` installed.
  },
  mappings = { -- override/add mappings
    status = { -- modify status buffer mappings
      -- Adds a mapping with 'B' as key that does the 'BranchPopup' command
      ['B'] = 'BranchPopup',
      ['q'] = 'Close',
      -- ['s'] = 'Stage',
      -- ['S'] = '', -- Disable Stage all
    }
  },
  -- Setting any section to `false` will make the section not render at all
  sections = {
    untracked = {
      folded = true
    },
    unstaged = {
      folded = true
    },
    staged = {
      folded = false
    },
    stashes = {
      folded = true
    },
    unpulled = {
      folded = true
    },
    unmerged = {
      folded = false
    },
    recent = {
      folded = false
    },
  },
}


vim.cmd([[
" Highlights
highlight! link NeogitDiffContextHighlight StatusLineNC
highlight NeogitCommitViewHeader guibg=none guifg=lightblue
highlight NeogitObjectId guibg=none guifg=#A056BB

augroup neogit_au
  autocmd!

  function! NeogitSettings()
    setlocal colorcolumn=
    setlocal cursorline
    setlocal nonumber
  endfunction

  " Disable number column for most window views
  autocmd FileType NeogitStatus call NeogitSettings()
  autocmd FileType NeogitLogView call NeogitSettings()
  autocmd FileType NeogitCommitView call NeogitSettings()

augroup END
]])
