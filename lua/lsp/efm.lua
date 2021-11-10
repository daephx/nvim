
-- TODO: efm-ls | Install deps golang if not exist
-- if not vim.fn.executable('go') then
--   vim.fn.system()
-- end

local lspconfig = require("lspconfig")

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {formatCommand = "lua-format -i", formatStdin = true}
            }
        }
    }
}
