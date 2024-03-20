-- nvim-unception | open files from terminal without nesting
-- https://github.com/samjwill/nvim-unception

---@type LazyPluginSpec
return {
  "samjwill/nvim-unception",
  enabled = false,
  config = function()
    vim.g.unception_enable_flavor_text = false
    vim.api.nvim_create_autocmd("User", {
      pattern = "UnceptionEditRequestReceived",
      callback = function()
        local wins = vim.api.nvim_list_wins()
        if #wins < 1 then
          vim.cmd("topleft split")
        end
        vim.api.nvim_set_current_win(wins[1])
      end,
    })
  end,
}
