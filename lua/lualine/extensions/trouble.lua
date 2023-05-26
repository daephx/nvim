-- MIT license, see LICENSE for more details.
-- Extension for Trouble.nvim

local function trouble_statusline()
  return "Trouble"
end

local function trouble_itemcount()
  return "# " .. #require("trouble").get_items()
end

local M = {}

M.sections = {
  lualine_a = { trouble_statusline },
  lualine_b = { trouble_itemcount },
  lualine_c = {
    {
      function()
        local cwd = vim.fn.getcwd()
        return cwd:gsub(vim.env.HOME, "~")
      end,
      icon = { "󰋊" },
    },
  },
  lualine_z = { "location" },
}

M.filetypes = { "Trouble" }

return M
