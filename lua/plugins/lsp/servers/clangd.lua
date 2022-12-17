-- Clangd language server configurations

return {
  -- cmd = {
  --   clangd_binary,
  --   '--background-index',
  --   -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
  --   -- to add more checks, create .clang-tidy file in the root directory
  --   -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
  --   '--clang-tidy',
  --   '--fallback-style=llvm',
  --   '--completion-style=bundled',
  --   '--cross-file-rename',
  --   '--header-insertion=iwyu',
  -- },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}
