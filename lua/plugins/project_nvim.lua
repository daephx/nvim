-- project_nvim | The superior project management solution for neovim.
-- https://github.com/ahmedkhalf/project.nvim
local project_ok, project_nvim = pcall(require, "project_nvim")
if not project_ok then
  return
end

project_nvim.setup({
  -- Show hidden files in telescope
  show_hidden = true,
  detection_methods = { "lsp", "pattern", "!.git/worktrees" },
  ignore_lsp = { "null-ls", "efm" },

  -- Don't calculate root dir on specific directories
  exclude_dirs = {
    "~/.cargo/*",
    "~/.local/include/*",
    "~/.luarocks/*",
    "~/Documents",
  },
  -- All the patterns used to detect root dir, when **"pattern"** is in detection_methods
  patterns = {
    ".bzr",
    ".clang-format",
    ".editorconfig",
    ".git",
    ".github",
    ".hg",
    ".project",
    ".sln",
    ".svn",
    ".terraform",
    "Makefile",
    "_darcs",
    "cargo.toml",
    "go.mod",
    "go.sum",
    "node_modules",
    "package.json",
    "requirements.txt",
    "requirements.yml",
  },
})

-- Apply telescope extension settings
local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
  -- Call telescope setup with extension configs
  telescope.setup({
    extensions = {
      project = {
        hidden_files = true, -- default: false
        base_dirs = {
          { "~/", max_depth = 2 },
          { "~/.dotfiles/", max_depth = 3 },
          { "~/Documents/Projects", max_depth = 4 },
          { "~/Projects", max_depth = 4 },
        },
      },
    },
  })

  -- Load telescope extension
  telescope.load_extension("projects")
end
