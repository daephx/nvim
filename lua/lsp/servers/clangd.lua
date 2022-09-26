-- Clangd language server configurations

local M = {}

M.setup = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
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
    flags = {
      debounce_text_changes = 150,
    },
  }
end

return M
