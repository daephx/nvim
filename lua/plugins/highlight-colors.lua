-- nvim-highlight-colors | Highlight colors for neovim
-- https://github.com/brenoprata10/nvim-highlight-colors

---@type LazySpec
return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    render = "background",
    enable_hex = true,
    enable_short_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_var_usage = true,
    enable_named_colors = false,
    enable_tailwind = true,
    custom_colors = {},
    exclude_filetypes = {},
    exclude_buftypes = {
      "nofile",
      "popup",
      "prompt",
    },
  },
}
