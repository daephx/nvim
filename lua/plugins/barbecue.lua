-- barbecue.nvim | A VS Code like winbar for Neovim
-- https://github.com/utilyre/barbecue.nvim

local function icons()
  return vim.tbl_map(function(icon)
    return icon
  end, require("core.icons").kinds)
end

return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    -- Code context for winbar/statusline
    "SmiteshP/nvim-navic",
    -- Adds file type icons to Vim plugins
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    kinds = icons(),
    show_modified = true,
    attach_navic = false,
    exclude_filetypes = {
      "",
      "dashboard",
      "git",
      "gitcommit",
      "terminal",
      "toggleterm",
    },
    theme = {
      separator = { link = "LineNr" },
    },
  },
  config = function(_, opts)
    require("barbecue").setup(opts)

    --- Autocmds ---

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "Get nvim-navic working with multiple tabs",
      group = vim.api.nvim_create_augroup("LspAttachNavic", {}),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, ev.buf)
        end
      end,
    })
  end,
}
