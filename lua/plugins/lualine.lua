-- lualine.nvim | Blazing fast statusline for neovim, written in pure lua
-- https://github.com/nvim-lualine/lualine.nvim

---@param str string
---@return function
local function insert_string(str)
  return function()
    return str
  end
end

local mode = {
  "mode",
  fmt = function(str)
    return str:sub(1, 1)
  end,
}

local filename = {
  "filename",
  path = 1,
  icon = { "󰋊" },
}

local branch = {
  "branch",
  icon = "",
}

-- Version control diff values
---@return table|nil
local diff_source = function()
  local gitsigns = vim.b["gitsigns_status_dict"]
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local diff = {
  "diff",
  source = diff_source,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic", "coc", "ale" },
  symbols = {
    hint = "󰌵",
    info = "",
    warn = "",
    error = "",
  },
}

local lsp_client = {
  "lsp_client",
  icon = { "", align = "right" },
}

local lsp_progress = {
  "lsp_progress",
  display_components = { { "title", "percentage" }, "lsp_client_name", "spinner" },
  spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
}

local windows = {
  "windows",
  disabled_buftypes = {
    "nowrite",
  },
  disabled_filetypes = {
    "NvimTree",
    "Trouble",
    "fugitive",
  },
}

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
      lualine_a = { mode },
      lualine_b = { branch, diff },
      lualine_c = { filename },
      lualine_x = { lsp_progress, lsp_client, diagnostics },
      lualine_y = { "filetype", "encoding", "fileformat" },
      lualine_z = { "location" },
    },
    tabline = {
      lualine_a = { insert_string("") },
      lualine_b = { windows },
      lualine_y = { "tabs" },
      lualine_z = { insert_string("") },
    },
    inactive_sections = {
      lualine_c = { filename },
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
