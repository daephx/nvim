-- lualine.nvim | Blazing fast statusline for neovim, written in pure lua
-- https://github.com/nvim-lualine/lualine.nvim
local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  return
end

--- Functions ---

-- Version control diff values
local diff_source = function()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- Put proper separators and gaps between components in sections
local process_sections = function(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < "x"
    for id, comp in ipairs(section) do
      if type(comp) ~= "table" then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = "" } or { left = "" }
    end
  end
  return sections
end

--- Settings  ---

lualine.setup({
  options = {
    theme = "auto",
    padding = 1, -- adds padding to the left and right of components
    icons_enabled = true, -- displays icons in alongside component
    globalstatus = true, -- Enable global statusline
    always_divide_middle = false,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", source = diff_source },
    },
    lualine_c = {},
    lualine_x = {
      {
        -- Applicable if lsp_progress is installed
        "lsp_progress",
        display_components = { { "title", "percentage" }, "lsp_client_name", "spinner" },
        -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
        -- colors = { spinner = colors.yellow },
        spinner_symbols = {
          "⠋",
          "⠙",
          "⠹",
          "⠸",
          "⠼",
          "⠴",
          "⠦",
          "⠧",
          "⠇",
          "⠏",
        },
      },
      {
        "diagnostics",
        -- Update diagnostics in insert mode
        update_in_insert = false,
        -- table of diagnostic sources, available sources:
        sources = { "nvim_diagnostic", "coc", "ale" },
        -- displays diagnostics from defined severity
        symbols = {
          hint = "",
          info = "",
          warn = "",
          error = "",
        },
      },
    },
    lualine_y = {
      { "filetype", icon_only = false },
      { "encoding" },
      { "fileformat" },
    },
    lualine_z = { "location" },
  },
  tabline = process_sections({
    lualine_a = {
      function()
        return ""
      end,
    },
    lualine_b = { "windows" },
    lualine_y = { "tabs" },
    lualine_z = {
      function()
        return ""
      end,
    },
  }),
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {
    "fugitive",
    "neoterm",
    "quickfix",
    "trouble",
  },
})
