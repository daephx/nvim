-- project_nvim | The superior project management solution for neovim.
-- https://github.com/ahmedkhalf/project.nvim

---@type LazySpec
return {
  "ahmedkhalf/project.nvim",
  cond = vim.fn.has("nvim-0.10") == 0,
  name = "project_nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Projects" },
  },
  opts = {
    -- Show hidden files in telescope
    show_hidden = true,
    detection_methods = { "lsp", "pattern", "!.git/worktrees" },
    ignore_lsp = { "null-ls", "efm", "taplo" },

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
      ".bzr", --  Bazaar repository
      ".clang-format", -- Clang formatting config
      ".editorconfig", -- Editorconfig file
      ".git", -- Git repository
      ".github", -- Github meta config
      ".hg", -- Mercurial repository
      ".luarc.json", -- Lua_LS configuration
      ".project", -- Eclipse project config
      ".sln", -- Visual Studio solution
      ".svn", -- Subversion repository
      ".terraform", -- HashiCorp Terraform config
      ".venv", -- Python virtual environment
      "Pipfile.lock", -- Python/Pipenv dependencies
      "_darcs", -- Darcs repository
      "cargo.toml", -- Rust/Cargo config
      "go.mod", -- Golang module config
      "go.sum", -- Golang checksums
      "node_modules", -- Node virtual environment
      "poetry.lock", -- Python/Poetry dependencies
      "requirements.txt", -- Python/Pip dependencies
    },
  },
}
