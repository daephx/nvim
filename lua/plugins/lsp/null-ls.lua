-- Null-ls | Neovim language server
-- https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ok, null_ls = pcall(require, "null-ls")
if not null_ok then
  return
end

local on_attach = require("plugins.lsp.attach")

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

null_ls.setup({
  on_attach = on_attach,
  sources = {
    -- General
    diagnostics.write_good,
    hover.dictionary,

    -- Git Version Control
    diagnostics.gitlint.with({
      condition = function(util)
        return util.root_has_file({ ".git" })
      end,
    }),
    code_actions.gitsigns.with({
      condition = function(util)
        return util.root_has_file({ ".git" })
      end,
    }),

    -- Lua
    diagnostics.luacheck.with({
      condition = function(utils)
        return utils.root_has_file({ ".luacheckrc" })
      end,
      extra_args = { "--globals", "vim" },
    }),
    formatting.lua_format.with({
      condition = function(utils)
        return utils.root_has_file({ ".lua_format" })
      end,
    }),
    formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
      end,
    }),

    -- Shellscript
    code_actions.shellcheck,
    diagnostics.shellcheck,
    formatting.shfmt.with({
      extra_args = {
        "--indent " .. vim.o.shiftwidth,
        "--switch-case-indent",
        "--func-next-line",
      },
    }),
    diagnostics.zsh,
    diagnostics.fish,
    formatting.fish_indent,

    -- Python
    diagnostics.flake8.with({ extra_args = { "--max-line-length=88" } }),
    formatting.black.with({ extra_args = { "--fast", "--quiet" } }),
    formatting.isort,

    -- Golang
    formatting.gofmt,
    formatting.goimports,

    -- C/C++/Rust
    formatting.clang_format,
    formatting.rustfmt,

    -- diagnostics.eslint,
    formatting.prettier.with({
      extra_filetypes = { "solidity" },
      extra_args = { "--no-semi" },
    }),

    -- Linter for Ansible playbooks, roles and collections.
    diagnostics.ansiblelint,
  },
})

-- Get list of null-ls sources
vim.api.nvim_create_user_command("NullLsSources", function()
  local sources = require("null-ls.sources")
  print(vim.inspect(vim.tbl_map(function(source)
    return source.name
  end, sources.get_available(vim.bo.filetype))))
end, {})

-- Override window options for null-ls info
vim.api.nvim_create_autocmd("FileType", {
  desc = "Override window options for null-ls info",
  group = vim.api.nvim_create_augroup("NullLsInfoBuffer", {}),
  pattern = "null-ls-info",
  callback = function()
    vim.api.nvim_win_set_config(0, { border = vim.g.border })
  end,
})
