---@type snacks.picker.Config
local explorer = {
  auto_close = true,
  focus = "list",
  layout = {
    preset = "default",
    -- Force enable preview in custom explorer layout
    preview = true, ---@diagnostic disable-line:assign-type-mismatch
  },
  actions = {
    bufadd = function(_, item)
      if vim.fn.bufexists(item.file) == 0 then
        local buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_buf_set_name(buf, item.file)
        vim.api.nvim_buf_call(buf, vim.cmd.edit)
      end
    end,
    confirm_nofocus = function(picker, item)
      if item.dir then
        picker:action("confirm")
      else
        picker:action("bufadd")
      end
    end,
  },
  win = {
    list = {
      keys = {
        ["o"] = "confirm",
        ["l"] = "confirm_nofocus",
        ["L"] = "confirm",
        ["<Left>"] = "confirm_nofocus",
        ["<Right>"] = "confirm",

        ["<PageUp>"] = { "list_scroll_up", mode = { "i", "n" } },
        ["<PageDown>"] = { "list_scroll_down", mode = { "i", "n" } },
      },
    },
  },
}

return explorer
