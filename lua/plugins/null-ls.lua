-- none-ls | null-ls.nvim reloaded / Use Neovim as a language server
-- https://github.com/nvimtools/none-ls.nvim
---@module "null-ls

-- Use Neovim as a language server
---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    -- Collection of useful lua functions
    { "nvim-lua/plenary.nvim" },
    -- Extra sources for none-ls.nvim
    { "nvimtools/none-ls-extras.nvim" },
    -- Luacheck diagnostics source for none-ls.nvim
    { "gbprod/none-ls-luacheck.nvim" },
  },
  opts = function()
    local nls = require("null-ls")
    local diagnostics = nls.builtins.diagnostics
    local formatting = nls.builtins.formatting
    local hover = nls.builtins.hover

    -- Defines sources that configure tools and features for null-ls integration.
    local opts = {
      sources = {
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
      },
    }

    -- NOTE: Additional sources are typically provided by external plugins, not by null-ls built-ins.
    -- Examples include `none-ls.extras`, `none-ls.luacheck`, and other sources no longer maintained.

    -- Adds `luacheck` as an additional source if it is available in the environment.
    local luacheck_ok, luacheck = pcall(require, "none-ls-luacheck.diagnostics.luacheck")
    if luacheck_ok then
      table.insert(
        opts.sources,
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
    opts.on_attach = function(client, bufnr)
      -- Fixes `gq` issues by resetting `formatexpr` for null-ls.
      -- SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
      vim.api.nvim_set_option_value("formatexpr", "", { buf = bufnr })

      -- Calls the default `on_attach` for all language servers.
      local on_attach = require("plugins.lsp.attach")
      on_attach(client, bufnr)
    end

    -- Override highlight groups for null-ls
    local colors = require("config.colors")
    colors.set_hl_autocmd(nil, {
      NullLsInfoBorder = { link = "FloatBorder" },
    })

    -- Adjusts window options for `null-ls-info`, such as setting a custom border style.
    vim.api.nvim_create_autocmd({ "FileType" }, {
      desc = "Override window options for filetype: null-ls-info",
      group = vim.api.nvim_create_augroup("NullLsInfoBuffer", { clear = true }),
      pattern = "null-ls-info",
      callback = function()
        vim.api.nvim_win_set_config(0, { border = vim.g.border })
      end,
    })

    return opts
  end,
}
