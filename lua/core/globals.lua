--    ________      __          __
--   / ____/ /___  / /_  ____ _/ /____
--  / / __/ / __ \/ __ \/ __ `/ / ___/
-- / /_/ / / /_/ / /_/ / /_/ / (__  )
-- \____/_/\____/_.___/\__,_/_/____/
-- =================================
-- Set global variables & functions

-- Easier Inspect lua objects
function _G.inspect(args)
  print(vim.inspect(args))
end

-- Useful functions to explore Lua objects
-- https://www.reddit.com/comments/p84iu2

function _G.put(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

function _G.put_text(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, "\n"), "\n")
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)
  return ...
end

-- Easier mapping function
function _G.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
