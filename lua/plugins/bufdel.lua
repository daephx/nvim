require('bufdel').setup {
  next = 'cycle',  -- or 'alternate'
  quit = true,
}

-- Overwrite `:bd` command to call BufDel
-- This prevents windows resizing for things like Nerd/Nvim Tree
vim.cmd[[:cnoreabbrev bd BufDel]]
