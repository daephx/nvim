local M = {}

function M.goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log").info

  return function(_, result, context)
    if result == nil or vim.tbl_isempty(result) then
      _ = log() and log(context.method, "No location found")
      return
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.islist(result) then
      util.show_document(result[1], "utf-8", { focus = true })
      if #result > 1 then
        util.set_qflist(util.locations_to_items(result, "utf-8"))
        vim.cmd("copen")
        vim.cmd("wincmd p")
      end
    else
      util.show_document(result, "utf-8", { focus = true })
    end
  end
end

return M
