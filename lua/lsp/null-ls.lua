-- Null-ls | Neovim language server
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim

local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  return
end

local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    completion.spell,
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
    formatting.black.with({ extra_args = { '--fast' } }),
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

    -- Trim whitespace
    formatting.trim_newlines.with({
      disabled_filetypes = {
        'rust', -- use rustfmt
      },
    }),

    formatting.trim_whitespace.with({
      disabled_filetypes = {
        'markdown',
        'rust', -- use rustfmt
      },
    }),
  },
  on_attach = function(client)
    if client.server_capabilities.document_formatting then
      vim.api.nvim_create_user_command('Format', vim.lsp.buf.range_formatting, {})
      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        desc = 'Apply Auto-formatting for to document on save',
        -- buffer = 0,
        callback = vim.lsp.buf.formatting_sync,
      })
    end
  end,
})
