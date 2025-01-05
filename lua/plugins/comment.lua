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
      vim.cmd.normal("gv")
    end
  end
end

---@type LazySpec
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

    -- Return callback function for visual mode keymaps
    local function locked(cb)
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      return function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.locked(cb)(vim.fn.visualmode())
      end
    end

    -- Define extended keymaps
    local util = require("config.util")
    util.register_keymaps(nil, {
      -- Windows Terminal: <c-_>
      { "i", "<c-_>", api.toggle.linewise.current },
      { "n", "<c-_>", api.toggle.linewise.current },
      { "x", "<c-_>", locked("toggle.linewise") },

      -- Kitty Terminal: <c-/>
      { "i", "<c-/>", api.toggle.linewise.current },
      { "n", "<c-/>", api.toggle.linewise.current },
      { "x", "<c-/>", locked("toggle.linewise") },

      -- Comment block selection
      { "i", "<a-A>", api.toggle.blockwise.current },
      { "n", "<a-A>", api.toggle.blockwise.current },
      { "x", "<a-A>", locked("toggle.blockwise") },
    })
  end,
}
