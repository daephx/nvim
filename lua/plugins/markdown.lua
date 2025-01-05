-- Configures plugins for Markdown files and note management.
-- Includes tools for editing/previewing and exploring Markdown files.

---@type LazySpec
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
  { -- Neovim extension for zk
    "zk-org/zk-nvim",
    main = "zk",
    cmd = {
      "ZkBacklinks",
      "ZkBuffers",
      "ZkCd",
      "ZkIndex",
      "ZkInsertLink",
      "ZkInsertLinkAtSelection",
      "ZkLinks",
      "ZkMatch",
      "ZkNew",
      "ZkNewFromContentSelection",
      "ZkNewFromTitleSelection",
      "ZkNotes",
      "ZkTags",
    },
    keys = {
      { "<leader>zb", "<cmd>ZkBacklinks<CR>", desc = "Show backlinks" },
      { "<leader>zf", "<cmd>ZkNotes<CR>", desc = "Show notes" },
      { "<leader>zl", "<cmd>ZkLinks<CR>", desc = "Show links" },
      { "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = "New note" },
    },
    opts = {
      -- Can be "telescope", "fzf" or "select" (`vim.ui.select`)
      -- It's recommended to use "telescope" or "fzf"
      picker = "telescope",
    },
  },
}
