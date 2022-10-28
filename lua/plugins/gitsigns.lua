-- gitsigns.nvim | Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim
local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_ok then
  return
end

gitsigns.setup({
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '▎',
      numhl = 'GitSignsAddNr',
      linehl = 'GitSignsAddLn',
    },
    change = {
      hl = 'GitSignsChange',
      text = '▎',
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '▎',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '▎',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '▎',
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  sign_priority = 6,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gitsigns.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Next hunk' })

    map('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gitsigns.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Previous hunk' })

    -- Actions
    map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage hunk' })
    map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset hunk' })
    map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'stage buffer' })
    map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
    map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
    map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
    map('n', '<leader>gb', function()
      gitsigns.blame_line({ full = true })
    end, { desc = 'Blame line' })
    map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame line' })
    map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff buffer' })
    map('n', '<leader>gD', function()
      gitsigns.diffthis('~')
    end, { desc = 'Diffthis ~' })
    map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = 'Toggle deleted' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
  end,
})
