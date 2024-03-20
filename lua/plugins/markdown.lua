-- lua/plugins/markdown.lua

---@type LazyPluginSpec[]
return {
  { -- Nice extra's for markdown documents
    "SidOfc/mkdx",
    ft = "markdown",
  },
  { -- Preview Markdown in the browser
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_preview_options = {
        hide_yaml_meta = 0,
        Disable_filename = 0,
        ["prefers-color-scheme"] = "dark",
      }
    end,
  },
}
