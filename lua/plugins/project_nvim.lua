-- project_nvim | The superior project management solution for neovim.
-- https://github.com/DrKJeff16/project.nvim

---@type LazySpec
return {
  "DrKJeff16/project.nvim",
  event = { "BufNewFile", "BufReadPre" },
  cmd = { "Project" },
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Projects" },
  },
  opts = {
    -- Show hidden files in telescope
    show_hidden = true,
    detection_methods = { "lsp", "pattern" },
    lsp = {
      enabled = true,
      ignore = { "null-ls", "efm", "taplo" },
    },

    -- Don't calculate root dir on specific directories
    exclude_dirs = {
      "~/.cargo/*", -- Rust package manager
      "~/.local/include/*", -- User XDG library
      "~/.luarocks/*", -- Luarocks Package directory
      "~/.venv/*", -- Python virtual environment
      "~/Documents", -- User documents directory
      "~/go/*", -- Golang home directory
      "~/node_modules/*", -- Node package directory
    },
    -- All the patterns used to detect root dir, when **"pattern"** is in detection_methods
    patterns = {
      -- General
      "!.git/worktrees", -- Ignore git worktrees
      ".bzr", --  Bazaar repository
      ".git", -- Git repository
      ".hg", -- Mercurial repository
      ".svn", -- Subversion repository
      "_darcs", -- Darcs repository
      ".github", -- Github meta config

      -- Editor
      ".editorconfig", -- Editorconfig file
      ".project", -- Eclipse project config
      ".terraform", -- HashiCorp Terraform config
      ".neoconf.json", -- Neovim/neoconf configuration file
      "neoconf.json", -- Neovim/neoconf configuration file

      -- Languages
      ".clang-format", -- Clang formatting config
      ".luarc.json", -- lua-language-server configuration
      ".sln", -- Visual Studio solution
      "cargo.toml", -- Rust/Cargo config
      "go.mod", -- Golang module config
      "go.sum", -- Golang checksums
      "node_modules", -- Node virtual environment

      ".venv", -- Python virtual environment
      "Pipfile.lock", -- Python/Pipenv dependencies
      "poetry.lock", -- Python/Poetry dependencies
      "requirements.txt", -- Python/Pip dependencies
      "uv.lock", -- Python/UV lockfile
    },
  },
}
