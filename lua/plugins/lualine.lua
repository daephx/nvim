-- lualine.nvim | Blazing fast statusline for neovim, written in pure lua
-- https://github.com/nvim-lualine/lualine.nvim

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

local diff = {
  "diff",
  ---Version control diff values
  ---@return table|nil
  source = function()
    local gitsigns = vim.b["gitsigns_status_dict"]
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    hint = "󰌵",
    info = "",
    warn = "",
    error = "",
  },
}

local lsp_info = {
  "lsp_info",
  icon = { "", align = "right" },
  client_names = {
    ["arduino_language_server"] = "arduino_ls",
    ["docker_compose_language_service"] = "docker-compose",
    ["fennel_language_server"] = "fennel_ls",
    ["pkgbuild_language_server"] = "pkgbuild_ls",
  },
}

local tabs = {
  "tabs",
  mode = 1,
  tabs_color = {
    active = "lualine_c_normal",
    inactive = "lualine_c_inactive",
  },
  -- Display tab label as name if set else use tabnr
  fmt = function(_name, ctx)
    local ok, tabname = pcall(vim.api.nvim_tabpage_get_var, ctx.tabId, "tabname")
    if ok and tabname ~= "" then
      return tabname
    end
    return ctx.tabnr
  end,
}

local windows = {
  "windows",
  windows_color = {
    active = "lualine_c_normal",
    inactive = "lualine_c_inactive",
  },
  filetype_names = {
    fugitive = "Fugitive",
    lazy = "Lazy",
  },
}

---@param str string
---@return function
local function insert_string(str)
  return function()
    return str
  end
end

---Override separators for tabline between components and sections
---@param sections table
---@return table
local function process_sections(sections)
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

---Set formatting rules for lsp_progress clients
---@param client_name string
---@param spinner table
---@param series_messages table
---@return string|nil
local function client_format(client_name, spinner, series_messages)
  local active_clients = vim.tbl_map(function(client)
    return client.name
  end, vim.lsp.get_active_clients({ bufnr = 0 }))
  if #series_messages > 0 and vim.tbl_contains(active_clients, client_name) then
    local messages = table.concat(series_messages, ", ")
    return ("%s %s [%s]"):format(messages, spinner, client_name)
  end
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    dependencies = {
      -- Lua fork of vim-web-devicons for neovim
      { "nvim-tree/nvim-web-devicons" },
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
        lualine_x = { lsp_info, diagnostics },
        lualine_y = { "filetype", "encoding", "fileformat" },
        lualine_z = { "location" },
      },
      tabline = {
        lualine_a = { insert_string("") },
        lualine_b = { windows },
        lualine_y = { tabs },
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
  },
  { -- A performant LSP progress status for Neovim
    "linrongbin16/lsp-progress.nvim",
    event = { "LspAttach" },
    dependencies = { "nvim-lualine/lualine.nvim" },
    opts = { client_format = client_format },
    config = function(_, opts)
      require("lsp-progress").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        desc = "listen for lsp-progress event and refresh lualine",
        group = vim.api.nvim_create_augroup("Lualine_LspProgressUpdate", {}),
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end,
  },
}
