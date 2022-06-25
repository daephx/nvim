-- Null-ls | Neovim language server
-- URL: https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ok, null_ls = pcall(require, 'null-ls')
if not null_ok then
  return
end

local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local M = {}

M.setup = function(_, on_attach)
  null_ls.setup({
    debug = true,
    on_attach = on_attach,
    sources = {
      -- completion.spell, -- NOTE: REMOVE ME, this little fucker is what is mucking up cmp
      completion.luasnip,

      -- Git - Version Control
      diagnostics.gitlint,
      code_actions.gitsigns,

      -- formatting.lua_format,
      formatting.stylua.with({
        condition = function(utils)
          return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
        end,
      }),

      -- Shell scripts
      -- formatting.shfmt,
      code_actions.shellcheck,
      diagnostics.shellcheck.with({
        -- diagnostics_format = "[#{c}] #{m} (#{s})"
      }),

      -- Python
      diagnostics.flake8,
      formatting.black,
      formatting.isort,

      -- Golang
      formatting.gofmt,
      formatting.goimports,

      -- C/C++/Rust
      formatting.clang_format,
      formatting.rustfmt,

      -- diagnostics.eslint,
      formatting.prettier.with({
        extra_filetypes = { 'toml', 'solidity' },
        extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
      }),

      -- Linter for Ansible playbooks, roles and collections.
      diagnostics.ansiblelint,
    },
  })
end

return M