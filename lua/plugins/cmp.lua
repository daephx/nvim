-- nvim-cmp | A completion plugin for neovim coded in Lua
-- https://github.com/hrsh7th/nvim-cmp

-- Return true if whitespace is detected before cursor position.
---@return boolean
local has_whitespace_before = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- Use buffers from the current tabpage, but omit man pages as they can
-- slow down neovim by being too large.
local search_tabpage = {
  get_bufnrs = function()
    local ret = {}
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local bufnr = vim.api.nvim_win_get_buf(winid)
      local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
      if ft ~= "man" then
        table.insert(ret, bufnr)
      end
    end
    return ret
  end,
}

-- Options for completion/documentation windows
local window_opts = {
  max_width = 80,
  border = vim.g.border,
  winhighlight = table.concat({
    "NormalFloat:NormalFloat",
    "FloatBorder:FloatBorder",
    "CursorLine:CursorLine",
    "Search:None",
  }, ","),
}

-- Truncate completion abbreviations to control width of float.
-- https://github.com/hrsh7th/nvim-cmp/issues/980#issuecomment-1121773499
---@param abbr string
---@return string
local truncate_abbreviation = function(abbr)
  local max_width = 60
  local min_width = 20
  local truncated_abbr = vim.fn.strcharpart(abbr, 0, max_width)
  if truncated_abbr ~= abbr then
    abbr = truncated_abbr .. "…"
  elseif string.len(abbr) < min_width then
    local padding = string.rep(" ", min_width - string.len(abbr))
    abbr = abbr .. padding
  end
  return abbr
end

local source_labels = {
  buffer = "[Buffer]",
  cmp_tabnine = "[TabNine]",
  copilot = "[Copilot]",
  crates = "[Crates]",
  git = "[Git]",
  latex_symbols = "[LaTex]",
  luasnip = "[LuaSnip]",
  neorg = "[Neorg]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Neovim]",
  path = "[Path]",
  spell = "[Spell]",
  ultisnips = "[UltiSnip]",
  vsnip = "[VSnip]",
  zsh = "[ZSH]",
}

-- Set source label for `vim_item.menu` in cmp popup menu.
-- If: source is nvim_lsp, replace `item.menu` with the clients name.
-- Else: set the appropriate label from `source_labels`.
---@param entry table
---@return string
local format_source_labels = function(entry)
  if entry.source.name == "nvim_lsp" then
    if entry.source.source.client then
      local name = entry.source.source.client.name
      return ("[%s]"):format(name)
    end
  end
  return source_labels[entry.source.name]
end

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      enable = true,
      formatting = {
        maxwidth = 120,
        fields = { "abbr", "kind", "menu" },
        format = function(entry, item)
          local kinds = require("core.icons").kinds
          item.max_width = 80
          item.mode = "text_symbol"
          item.kind = ("%s %s"):format(kinds[item.kind], item.kind)
          item.menu = format_source_labels(entry)
          item.abbr = truncate_abbreviation(item.abbr)
          return item
        end,
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),

        ["<Down>"] = cmp.mapping({
          n = cmp.mapping.select_next_item(),
          c = cmp.mapping.select_prev_item(),
          i = cmp.config.disable,
        }),

        ["<Up>"] = cmp.mapping({
          n = cmp.mapping.select_prev_item(),
          c = cmp.mapping.select_next_item(),
          i = cmp.config.disable,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and not has_whitespace_before() then
            cmp.confirm({ select = true })
          elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", option = search_tabpage },
        { name = "path", option = { trailing_slash = true } },
      }),
      experimental = {
        native_menu = false,
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
      completion = {
        completeopt = "menu,menuone,noselect",
        keyword_length = 1,
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      performance = { max_view_entries = 25 },
      window = {
        completion = window_opts,
        documentation = window_opts,
      },
      view = {
        entries = {
          name = "custom",
          selection_order = "near_cursor",
        },
      },
    })

    -- Use cmdline & path source for ':'
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      preselect = cmp.PreselectMode.None,
      sources = cmp.config.sources({
        { name = "cmdline_history" },
        -- Do not show completion for words starting with '!'
        { name = "cmdline", keyword_pattern = "\\!@<!\\w*" },
      }, {
        { name = "path", option = { trailing_slash = true } },
      }),
    })

    -- Use buffer source for `/`, '?'
    -- (if you enabled `native_menu`, this won't work anymore).
    local search_opts = {
      sources = cmp.config.sources({
        { name = "buffer", option = search_tabpage },
      }),
    }

    cmp.setup.cmdline("/", search_opts)
    cmp.setup.cmdline("?", search_opts)

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" },
        { name = "buffer", option = search_tabpage },
        { name = "path" },
      }, {
        { name = "spell" },
      }),
    })

    cmp.setup.filetype("markdown", {
      sources = cmp.config.sources({
        { name = "buffer", option = search_tabpage },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path", option = { trailing_slash = true } },
      }, {
        { name = "spell" },
      }),
    })
  end,
}
