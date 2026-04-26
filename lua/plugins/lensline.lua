-- lensline.nvim | Modular nvim codelens support
-- https://github.com/oribarilan/lensline.nvim

---@type LazySpec
return {
  "oribarilan/lensline.nvim",
  branch = "release/2.x",
  event = { "LspAttach" },
  opts = {
    profiles = {
      {
        name = "minimal",
        style = {
          highlight = "NonText",
          placement = "inline",
          prefix = " ",
        },
        providers = {
          {
            name = "usages",
            enabled = true,
            breakdown = true,
            highlight = "LspCodeLens",
          },
          {
            name = "last_author",
            enabled = false,
          },
        },
      },
    },
  },
}
