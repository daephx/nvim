-- Comment.nvim | Smart and powerful comment plugin for neovim
-- https://github.com/numToStr/Comment.nvim
local comment_ok, comment = pcall(require, 'Comment')
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
  ignore = '^$',
  toggler = {
    line = '<c-_>',
    block = '<a-A>',
  },
  mappings = {
    basic = true,
    extra = true,
  },
  post_hook = post_hook,
})

--- Keymaps ---

local map = vim.keymap.set

map('x', '<c-_>', '<Plug>(comment_toggle_linewise_visual)', {
  desc = 'Comment toggle linewise',
})
map('x', '<a-A>', '<Plug>(comment_toggle_blockwise_visual)', {
  desc = 'Comment toggle blockwise',
})
