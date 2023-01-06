-- Comment.nvim | Smart and powerful comment plugin for neovim
-- https://github.com/numToStr/Comment.nvim
local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
  return
end

--- Helpers ---

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

--- Setup ---

comment.setup({
  padding = true,
  sticky = true,
  ignore = "^$",
  mappings = {
    basic = true,
    extra = true,
  },
  post_hook = post_hook,
})

--- Keymaps ---

local api = require("Comment.api")
local map = vim.keymap.set

-- Utilizing Comment.nvim extended keymaps
-- Includes duplicate mappings due to terminal differences
-- + Kitty Terminal   | <c-/>
-- + Windows Terminal | <c-_>

-- Insert
map("i", "<c-/>", api.toggle.linewise.current)
map("i", "<c-_>", api.toggle.linewise.current)

-- Normal
map("n", "<c-/>", api.toggle.linewise.current)
map("n", "<c-_>", api.toggle.linewise.current)

-- Visual
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

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
