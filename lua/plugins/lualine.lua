-- lualine.nvim | Blazing fast statusline for neovim, written in pure lua
-- https://github.com/nvim-lualine/lualine.nvim

--- Helpers ---

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

-- Put proper separators and gaps between components in sections
---@param sections table
---@return table
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

return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  dependencies = {
    -- Lua fork of vim-web-devicons for neovim
    { "nvim-tree/nvim-web-devicons" },
    -- Display LSP progress in the statusline
    { "arkav/lualine-lsp-progress" },
  },
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
    tabline = process_sections({
      lualine_a = {
        function()
          return ""
        end,
      },
      lualine_b = {
        {
          "custom_windows",
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
      lualine_y = { "custom_tabs" },
      lualine_z = {
        function()
          return ""
        end,
      },
    }),
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
