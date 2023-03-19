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
  ignore_lsp = { "null-ls", "efm", "taplo" },

  -- Don't calculate root dir on specific directories
  exclude_dirs = {
    "~/.cargo/*",
    "~/.local/include/*",
    "~/.luarocks/*",
    "~/.venv/*",
    "~/Documents",
    "~/node_modules/*",
  },
  -- All the patterns used to detect root dir, when **"pattern"** is in detection_methods
  patterns = {
    ".bzr", --  Bazaar repository
    ".clang-format", -- Clang formatting config
    ".editorconfig", -- Editorconfig file
    ".git", -- Git repository
    ".github", -- Github meta config
    ".hg", -- Mercurial repository
    ".project", -- Eclipse project config
    ".sln", -- Visual Studio solution
    ".svn", -- Subversion repository
    ".terraform", -- HashiCorp Terraform config
    ".venv", -- Python virtual environment
    "Pipfile.lock", -- Python/Pip requirements
    "_darcs", -- Darcs repository
    "cargo.toml", -- Rust/Cargo config
    "go.mod", -- Golang module config
    "go.sum", -- Golang checksums
    "node_modules", -- Node virtual environment
    "poetry.lock", -- Python/Pip requirements
    "requirements.txt", -- Python/Pip requirements
    "requirements.yml", -- Python/Pip requirements
  },
})

-- Apply telescope extension settings
local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
  -- Initialize telescope extension
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
  telescope.load_extension("projects")
end
