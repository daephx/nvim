-- Null-ls | Neovim language server
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim

local M = {}

local null_ls = require('null-ls')

M.setup = function()
  null_ls.setup({
    debug = false,
    sources = {
      null_ls.builtins.completion.spell,
      null_ls.builtins.completion.luasnip,

      -- null_ls.builtins.formatting.lua_format,
      null_ls.builtins.formatting.stylua.with({
        condition = function(utils)
          return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
        end,
      }),

      -- Shell scripts
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.shellcheck.with({
        -- diagnostics_format = "[#{c}] #{m} (#{s})"
      }),
      -- null_ls.builtins.formatting.shfmt,

      -- Python
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,

      -- null_ls.builtins.diagnostics.eslint,
      -- null_ls.builtins.formatting.prettier,
      -- null_ls.builtins.formatting.clang_format,
      -- null_ls.builtins.formatting.gofmt,
      -- null_ls.builtins.formatting.goimports,
      -- null_ls.builtins.formatting.rustfmt,

      -- Linter for Ansible playbooks, roles and collections.
      -- null_ls.builtins.diagnostics.ansiblelint

      -- Linter for git commit messages
      -- null_ls.builtins.diagnostics.gitlint,
    },
  })
end

return M
