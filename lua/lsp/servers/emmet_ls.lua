-- emmet-ls: Language-server configuration

return {
  -- filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  -- filetypes = { 'html', 'css', 'tsx', 'jsx', 'sass', 'scss', 'less' },
  root_dir = function()
    return vim.loop.cwd()
  end,
}
