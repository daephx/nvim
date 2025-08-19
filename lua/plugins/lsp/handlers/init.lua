-- HACK: Apply border to all lsp floating windows
vim.lsp.util.open_floating_preview = (function(orig)
  return function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or vim.g.border
    opts.focusable = false
    return orig(contents, syntax, opts, ...)
  end
end)(vim.lsp.util.open_floating_preview)

-- Hover handler with custom border style
vim.lsp.buf.hover({
  border = vim.g.border,
})

-- NOTE: Doesn't seem to work with signatureHelp plugin
-- Signature help handler with custom border and close events
vim.lsp.buf.signature_help({
  border = vim.g.border,
  close_events = { "BufHidden", "CursorMoved", "CursorMovedI", "InsertCharPre" },
  focusable = false,
  silent = true,
})
