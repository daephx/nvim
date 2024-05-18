-- none-ls | null-ls.nvim reloaded / Use Neovim as a language server
-- https://github.com/nvimtools/none-ls.nvim
local null_ls = require("null-ls")
local on_attach = require("plugins.lsp.attach")

-- Get list of null-ls sources
vim.api.nvim_create_user_command("NullLsSources", function()
  local sources = require("null-ls.sources")
  vim.notify(vim.inspect(vim.tbl_map(function(source)
    return source.name
  end, sources.get_available(vim.bo.filetype))))
end, {})

-- Fix window options for null-ls-info eg. border
vim.api.nvim_create_autocmd("FileType", {
  desc = "Override window options for filetype: null-ls-info",
  group = vim.api.nvim_create_augroup("NullLsInfoBuffer", {}),
  pattern = "null-ls-info",
  callback = function()
    vim.api.nvim_win_set_config(0, { border = vim.g.border })
  end,
})

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

return {
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

    -- Lua
    diagnostics.luacheck.with({
      condition = function(utils)
        return utils.root_has_file({ ".luacheckrc" })
      end,
    }),
    diagnostics.selene.with({
      condition = function(utils)
        return utils.root_has_file({ "selene.toml" })
      end,
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
    -- code_actions.shellcheck,
    -- diagnostics.shellcheck,
    formatting.shfmt,
    diagnostics.zsh,
    diagnostics.fish,
    formatting.fish_indent,

    -- Python
    formatting.black.with({ prefer_local = ".venv/bin" }),

    diagnostics.ruff.with({ prefer_local = ".venv/bin" }),
    formatting.ruff.with({ prefer_local = ".venv/bin" }),

    -- Golang
    formatting.gofmt,
    formatting.goimports,

    -- CSharp
    formatting.csharpier,

    -- Clang
    formatting.clang_format.with({
      condition = function(utils)
        return utils.root_has_file({ ".clang-format" })
      end,
    }),

    -- Rust
    formatting.rustfmt,

    -- Markdown
    diagnostics.markdownlint,
    formatting.cbfmt.with({
      condition = function(util)
        return util.root_has_file(".cbfmt.toml")
      end,
    }),

    -- JavaScript, etc.
    diagnostics.eslint_d.with({
      condition = function(util)
        return util.root_has_file(".eslintrc.js")
      end,
    }),

    formatting.prettier.with({
      prefer_local = "node_modules/.bin",
      extra_filetypes = { "solidity", "svelte", "yaml" },
    }),
  },
  on_attach = function(client, bufnr)
    -- null-ls causes problems with the default formatexpr, which messes up `gq`
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
    vim.api.nvim_set_option_value("formatexpr", "", { buf = bufnr })
    on_attach(client, bufnr)
  end,
}
