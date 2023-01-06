-- git-conflict.nvim | Visualise and resolve merge conflicts in neovim
-- https://github.com/akinsho/git-conflict.nvim
local conflict_ok, conflict = pcall(require, "git-conflict")
if not conflict_ok then
  return
end

--- Setup ---

conflict.setup({
  default_mappings = true,
  disable_diagnostics = true,
})
