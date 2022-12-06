-- Null-ls | Neovim language server
-- https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ok, null_ls = pcall(require, 'null-ls')
if not null_ok then
  return
end

local on_attach = require('plugins.lsp.attach')

local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  on_attach = on_attach,
  sources = {
    completion.luasnip,

    -- Git - Version Control
    diagnostics.gitlint,
    code_actions.gitsigns,

    diagnostics.luacheck.with({
      condition = function(utils)
        return utils.root_has_file({ '.luacheckrc' })
      end,
      extra_args = { '--globals', 'vim' },
    }),
    formatting.lua_format.with({
      condition = function(utils)
        return utils.root_has_file({ '.lua_format' })
      end,
    }),
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

-- Override window options for null-ls info
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Override window options for null-ls info',
  group = vim.api.nvim_create_augroup('NullLsInfoBuffer', {}),
  pattern = 'null-ls-info',
  callback = function()
    vim.api.nvim_win_set_config(0, { border = 'single' })
  end,
})
