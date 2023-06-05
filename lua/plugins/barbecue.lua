-- barbecue.nvim | A VS Code like winbar for Neovim
-- https://github.com/utilyre/barbecue.nvim

return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  event = { "LspAttach" },
  dependencies = {
    -- Quickstart configs for Nvim LSP
    "neovim/nvim-lspconfig",
    -- Code context for winbar/statusline
    "SmiteshP/nvim-navic",
    -- Adds file type icons to Vim plugins
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    kinds = require("core.icons").kinds,
    show_modified = true,
    attach_navic = false,
    create_autocmd = false,
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
  init = function()
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
  config = function(_, opts)
    require("barbecue").setup(opts)

    vim.api.nvim_create_autocmd({
      "BufWinEnter",
      "BufWritePost",
      "CursorHold",
      "InsertLeave",
      "TextChanged",
      "TextChangedI",
      "WinScrolled",
    }, {
      desc = "Gain better performance when moving the cursor around",
      group = vim.api.nvim_create_augroup("barbecue#create_autocmd", {}),
      callback = function()
        ---@diagnostic disable-next-line:await-in-sync
        require("barbecue.ui").update()
      end,
    })
  end,
}
