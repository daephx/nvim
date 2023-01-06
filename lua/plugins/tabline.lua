-- tabline.nvim | A "buffer and tab" tabline for neovim
-- https://github.com/kdheepak/tabline.nvim
local tabline_ok, tabline = pcall(require, "tabline")
if not tabline_ok then
  return
end

tabline.setup({
  options = {
    -- If lualine is installed tabline will use separators configured in lualine by default.
    -- These options can be used to override those settings.
    component_separators = { "", "" },
    section_separators = { "", "" },
    -- shows base filename only instead of relative path in filename
    show_filename_only = true,
  },
})
