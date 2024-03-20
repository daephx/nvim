-- Comment.nvim | Smart and powerful comment plugin for neovim
-- https://github.com/numToStr/Comment.nvim

-- Apply post command hook for applying comments
-- Prevent cursor from moving and reapply visual selection
---@param ctx table
local post_hook = function(ctx)
  if ctx.range.scol == -1 then
    return
  else
    if ctx.range.ecol > 400 then
      ctx.range.ecol = 1
    end

    if ctx.cmotion > 1 then
      -- Reselect visual lines
      vim.cmd([[exe "norm! gv"]])
    end
  end
end

---@type LazyPluginSpec
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ignore = "^$",
    padding = true,
    sticky = true,
    post_hook = post_hook,
    mappings = {
      basic = true,
      extra = true,
    },
  },
  config = function(_, opts)
    require("Comment").setup(opts)
    local api = require("Comment.api")
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    local map = vim.keymap.set

    map("i", "<c-_>", api.toggle.linewise.current)
    map("n", "<c-_>", api.toggle.linewise.current)
    map("n", "<c-/>", api.toggle.linewise.current)
    map("i", "<c-/>", api.toggle.linewise.current)

    -- Utilizing Comment.nvim extended keymaps
    -- Includes duplicate mappings due to terminal differences
    -- + Kitty Terminal   | <c-/>
    -- + Windows Terminal | <c-_>

    map("x", "<c-_>", function()
      vim.api.nvim_feedkeys(esc, "nx", false)
      api.locked("toggle.linewise")(vim.fn.visualmode())
    end, { desc = "Comment toggle linewise (visual)" })

    map("x", "<c-/>", function()
      vim.api.nvim_feedkeys(esc, "nx", false)
      api.locked("toggle.linewise")(vim.fn.visualmode())
    end, { desc = "Comment toggle linewise (visual)" })

    map("x", "<a-A>", function()
      vim.api.nvim_feedkeys(esc, "nx", false)
      api.locked("toggle.blockwise")(vim.fn.visualmode())
    end, { desc = "Comment toggle blockwise (visual)" })
  end,
}
