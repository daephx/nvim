-- opencode | Seamlessly integrate the opencode AI assistant with Neovim
-- https://github.com/NickvanDyke/opencode.nvim

---@type LazySpec
return {
  "NickvanDyke/opencode.nvim",
  enabled = true,
  event = { "VeryLazy" },
  dependencies = {
    -- Recommended for better prompt input,
    -- and required to use opencode.nvim's embedded terminal — otherwise optional
    { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  },
  -- stylua: ignore
  keys = {
    -- Recommended keymaps
    { '<leader>oA', function() require('opencode').ask() end, desc = 'Ask opencode' },
    { '<leader>oa', function() require('opencode').ask('@cursor: ') end, desc = 'Ask opencode about this', mode = 'n' },
    { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v' },
    { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session' },
    { '<leader>oo', function() require('opencode').toggle() end, desc = 'Open opencode' },
    { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v' } },
    { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode' },
    { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message' },

    { '<S-C-d>', function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down' },
    { '<S-C-u>', function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up' },

    -- Example: keymap for custom prompt
    { '<leader>oe', function() require('opencode').prompt("Explain @cursor and its context") end, desc = "Explain code near cursor" },
  },
  config = function()
    ---@module opencode
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      terminal = {
        win = {
          -- Enter the terminal window when opened
          enter = true,
        },
      },
    }

    -- Listen for opencode events
    vim.api.nvim_create_autocmd("User", {
      pattern = { "OpencodeEvent" },
      callback = function(args)
        -- See the available event types and their properties
        -- vim.notify(vim.inspect(args), vim.log.levels.DEBUG)
        -- Do something interesting, like show a notification when opencode finishes responding
        if args.data.type == "session.idle" then
          vim.notify("Opencode finished responding", vim.log.levels.INFO)
        end
      end,
    })
  end,
}
