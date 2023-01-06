-- ZenMode | Distraction-free coding for Neovim
-- https://github.com/folke/zen-mode.nvim
local zenmode_ok, zenmode = pcall(require, "zen-mode")
if not zenmode_ok then
  return
end

zenmode.setup({
  backdrop = 1, -- Backdrop shade: Set to 1 to keep the same as Normal.
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
    local bufnr = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
      vim.api.nvim_win_set_width(win, 1000)
    end
  end,
})

--- Keymaps ---

vim.keymap.set("n", "<c-w>z", "<cmd>ZenMode<CR>", { desc = "Enable ZenMode" })
