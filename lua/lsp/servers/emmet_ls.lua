-- Emmet support based on LSP.

local M = {}

M.setup = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
    -- filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    -- filetypes = { 'html', 'css', 'tsx', 'jsx', 'sass', 'scss', 'less' },
    root_dir = function()
      return vim.loop.cwd()
    end,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

return M
