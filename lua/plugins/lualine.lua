-- lualine.nvim | Blazing fast statusline for neovim, written in pure lua
-- https://github.com/nvim-lualine/lualine.nvim

--- Helpers ---

---@param str string
---@return function
local function insert_string(str)
  return function()
    return str
  end
end

-- Version control diff values
---@return table|nil
local diff_source = function()
  ---@diagnostic disable-next-line:undefined-field
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- Override separators for tabline between components and sections
---@param sections table
---@return table
local process_sections = function(sections)
  for _, section in pairs(sections) do
    for id, comp in ipairs(section) do
      if type(comp) ~= "table" then
        comp = { comp }
        section[id] = comp
      end
      comp.component_separators = { left = "", right = "" }
      comp.section_separators = { left = "", right = "" }
    end
  end
  return sections
end

--- Settings  ---

return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  dependencies = {
    -- Lua fork of vim-web-devicons for neovim
    { "nvim-tree/nvim-web-devicons" },
    -- Display LSP progress in the statusline
    { "arkav/lualine-lsp-progress" },
  },
  config = function(_, opts)
    -- Invert tabline separators before loading plugin
    opts.tabline = process_sections(opts.tabline)
    require("lualine").setup(opts)
  end,
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
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
      lualine_c = {
        {
          "filename",
          icon = { "󰋊" },
          path = 1,
        },
      },
      lualine_x = {
        {
          "lsp_progress",
          display_components = { { "title", "percentage" }, "lsp_client_name", "spinner" },
          spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        },
        { "lsp_client" },
        {
          "diagnostics",
          sources = { "nvim_diagnostic", "coc", "ale" },
          symbols = {
            hint = "󰌵",
            info = "",
            warn = "",
            error = "",
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
    tabline = {
      lualine_a = { insert_string("") },
      lualine_b = {
        {
          "windows",
          disabled_buftypes = {
            "nowrite",
          },
          disabled_filetypes = {
            "NvimTree",
            "Trouble",
            "fugitive",
          },
        },
      },
      lualine_y = { "tabs" },
      lualine_z = { insert_string("") },
    },
    inactive_sections = {
      lualine_c = {
        { "filename", path = 1 },
      },
    },
    extensions = {
      "dashboard",
      "fugitive",
      "lazy",
      "quickfix",
      "terminal",
      "trouble",
    },
  },
}
