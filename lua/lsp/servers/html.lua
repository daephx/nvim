local M = {}

M.setup = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      html = {
        format = {
          templating = true,
          wrapLineLength = 120,
          wrapAttributes = 'auto',
        },
        hover = {
          documentation = true,
          references = true,
        },
      },
    },
    flags = {
      debounce_text_changes = 150,
    },
  }
end

return M
