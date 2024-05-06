-- nvim-cmp | A completion plugin for neovim coded in Lua
-- https://github.com/hrsh7th/nvim-cmp
---@diagnostic disable: missing-fields, inject-field

-- Return true if whitespace is detected before cursor position.
---@return boolean
local has_whitespace_before = function()
  local col = vim.fn.col(".") - 1
  local line = vim.api.nvim_get_current_line()
  return col == 0 or line:sub(col, col):match("%s")
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
    "CursorLine:PmenuSel",
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
  treesitter = "[Treesitter]",
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

---@type LazyPluginSpec
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")

    -- HACK: Disable default completion mapping
    -- When the cmp window isn't visible this will open the default completion menu
    vim.keymap.set("i", "<C-n>", "<nop>")
    vim.keymap.set("i", "<C-p>", "<nop>")

    cmp.setup({
      enable = true,
      formatting = {
        maxwidth = 120,
        fields = { "abbr", "kind", "menu" },
        format = function(entry, item)
          local kinds = require("config.icons").kinds
          item.dup = nil
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
        ["<C-PageUp>"] = cmp.mapping.scroll_docs(-4),
        ["<C-PageDown>"] = cmp.mapping.scroll_docs(4),
        ["<C-Up>"] = cmp.mapping.scroll_docs(-1),
        ["<C-Down>"] = cmp.mapping.scroll_docs(1),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "none" }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "none" }),
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
        { name = "path", option = { trailing_slash = true } },
      }, {
        { name = "buffer", option = search_tabpage },
        { name = "spell" },
      }),
      experimental = {
        native_menu = false,
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
      completion = {
        get_trigger_characters = function(chars)
          local extras = { "!", "#", "-", "." }
          return vim.list_extend(chars, extras)
        end,
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

    -- Define options for cmdline: `:`
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "nvim_lua" },
      }, {
        { name = "path", option = { trailing_slash = true } },
      }, {
        { name = "cmdline_history" },
      }),
    })

    -- Define options for search commands: `/`, `?`
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "buffer", option = search_tabpage },
      }, {
        { name = "cmdline_history" },
      }),
    })

    -- Define specific sources for gitcommit filetype
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" },
        { name = "path", option = { trailing_slash = true } },
      }, {
        { name = "buffer", option = search_tabpage },
        { name = "spell" },
      }),
    })
  end,
}
