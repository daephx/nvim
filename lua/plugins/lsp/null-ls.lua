-- none-ls | null-ls.nvim reloaded / Use Neovim as a language server
-- https://github.com/nvimtools/none-ls.nvim
---@module "null-ls

local null_ls = require("null-ls")

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

local M = {}

-- Defines sources that configure tools and features for null-ls integration.
M.sources = {
  -- General
  hover.dictionary,

  -- Git Version Control
  diagnostics.gitlint.with({
    condition = function(util)
      return util.root_has_file({ ".git" })
    end,
  }),

  -- Lua
  diagnostics.selene.with({
    condition = function(utils)
      return utils.root_has_file({ "selene.toml" })
    end,
  }),
  formatting.stylua.with({
    condition = function(utils)
      return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
    end,
  }),

  -- Shell
  formatting.shfmt,
  diagnostics.zsh,

  -- Python
  formatting.black.with({ prefer_local = ".venv/bin" }),

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

  -- Markdown
  diagnostics.markdownlint,
  formatting.cbfmt.with({
    condition = function(util)
      return util.root_has_file(".cbfmt.toml")
    end,
  }),

  -- JavaScript, etc.
  formatting.prettier.with({
    prefer_local = "node_modules/.bin",
    extra_filetypes = { "solidity", "svelte", "yaml" },
  }),
}

-- NOTE: Additional sources are typically provided by external plugins, not by null-ls built-ins.
-- Examples include `none-ls.extras`, `none-ls.luacheck`, and other sources no longer maintained.

-- Adds `luacheck` as an additional source if it is available in the environment.
local luacheck_ok, luacheck = pcall(require, "none-ls-luacheck.diagnostics.luacheck")
if luacheck_ok then
  table.insert(
    M.sources,
    luacheck.with({
      condition = function(utils)
        return utils.root_has_file({ ".luacheckrc" })
      end,
    })
  )
end

---Apply custom settings for attached buffers
---@param client vim.lsp.Client
---@param bufnr integer
M.on_attach = function(client, bufnr)
  -- Fixes `gq` issues by resetting `formatexpr` for null-ls.
  -- SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
  vim.api.nvim_set_option_value("formatexpr", "", { buf = bufnr })

  -- Calls the default `on_attach` for all language servers.
  local on_attach = require("plugins.lsp.attach")
  on_attach(client, bufnr)
end

-- Defines a custom command to list active null-ls sources for the current buffer's filetype.
vim.api.nvim_create_user_command("NullLsSources", function()
  local sources = require("null-ls.sources")
  vim.notify(vim.inspect(vim.tbl_map(function(source)
    return source.name
  end, sources.get_available(vim.bo.filetype))))
end, {})

-- Adjusts window options for `null-ls-info`, such as setting a custom border style.
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Override window options for filetype: null-ls-info",
  group = vim.api.nvim_create_augroup("NullLsInfoBuffer", {}),
  pattern = "null-ls-info",
  callback = function()
    vim.api.nvim_win_set_config(0, { border = vim.g.border })
  end,
})

return M
