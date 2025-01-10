-- oil.nvim | Neovim file explorer: edit your filesystem like a buffer
-- https://github.com/stevearc/oil.nvim
---@module "oil"

-- Mapping of file permission characters to their respective highlight groups.
-- Used to apply syntax highlighting to each character in a permission string.
local permission_hlgroups = {
  ["-"] = "NonText",
  ["r"] = "DiagnosticSignWarn",
  ["w"] = "DiagnosticSignError",
  ["x"] = "DiagnosticSignOk",
}

---Generate highlight groups for file permissions.
---Maps each character in the permission string to a highlight group
---based on the `permission_hlgroups` table.
---@param perm string Permission string (e.g., "rwxr-xr-x")
---@return table
local permission_highlights = function(perm)
  local hls = {}
  for i = 1, #perm do
    local char = perm:sub(i, i)
    table.insert(hls, { permission_hlgroups[char], i - 1, i })
  end
  return hls
end

-- Tracks whether the details view is currently enabled
local details_enabled = false

-- Toggle file permission details in the Oil plugin.
-- Adds or removes columns like permissions, size, and mtime.
local enable_details = function()
  details_enabled = not details_enabled
  if not details_enabled then
    require("oil").set_columns({ "icon", add_padding = false })
  else
    require("oil").set_columns({
      { "permissions", highlight = permission_highlights },
      { "size", highlight = "Special" },
      { "mtime", highlight = "Number" },
      { "icon", add_padding = false },
    })
  end
end

---@type LazySpec
return {
  "stevearc/oil.nvim",
  dependencies = {
    -- Adds file type icons to Vim plugins
    { "nvim-tree/nvim-web-devicons" },
  },
  cmd = {
    "Oil",
    "Explore",
    "Fexplore",
    "Sexplore",
    "Vexplore",
  },
  keys = {
    { "<leader>e", "<cmd>Oil --float<cr>", desc = "File explorer" },
  },
  init = function()
    -- HACK: Due to lazy-loading, the plugin is not available during the `VimEnter` event
    -- which breaks the ability to launch directories via `nvim $PWD`
    vim.api.nvim_create_autocmd({ "UIEnter" }, {
      desc = "Open file explorer when launching neovim with a directory path",
      group = vim.api.nvim_create_augroup("Oil#OpenDirectory", { clear = true }),
      callback = function(ev)
        if vim.fn.isdirectory(ev.file) == 1 then
          require("oil").open(ev.file)
        end
      end,
    })
  end,
  config = function(_, opts)
    require("oil").setup(opts)

    -- Set custom vim style explorer commands
    local cmd_opts = { nargs = "?", complete = "dir" }
    local create_command = vim.api.nvim_create_user_command
    create_command("Explore", "Oil <args>", cmd_opts)
    create_command("Fexplore", "Oil --float <args>", cmd_opts)
    create_command("Sexplore", "belowright split | Oil <args>", cmd_opts)
    create_command("Texplore", "tabedit % | Oil <args>", cmd_opts)
    create_command("Vexplore", "rightbelow vsplit | Oil <args>", cmd_opts)
  end,
  ---@type oil.setupOpts
  opts = {
    -- Oil will take over directory buffers
    default_file_exporer = true,
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = true,
    -- Keymaps in oil buffer.
    keymaps = {
      ["q"] = "actions.close",
      ["<c-b>"] = "actions.preview_scroll_up",
      ["<c-d>"] = "actions.preview_scroll_down",
      ["<M-p>"] = "actions.preview",
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = enable_details,
      },
    },
    -- Buffer-local options to use for oil buffers
    buf_options = {
      bufhidden = "hide",
      buflisted = false,
    },
    -- Window-local options to use for oil buffers
    win_options = {
      colorcolumn = "0",
      concealcursor = "nvic",
      conceallevel = 3,
      cursorcolumn = false,
      foldcolumn = "0",
      number = false,
      relativenumber = false,
      signcolumn = "no",
      statuscolumn = "",
    },
    view_options = {
      show_hidden = true,
    },
    -- Configuration for the floating window in oil.open_float
    float = {
      border = vim.g.border,
      max_height = 32,
      max_width = 155,
      win_options = {
        winblend = 0,
      },
    },
    -- Configuration for the actions floating preview window
    preview = {
      border = vim.g.border,
      min_width = { 50, 0.5 },
    },
    -- Configuration for the floating progress window
    progress = {
      border = vim.g.border,
    },
    -- Configuration for the floating SSH window
    ssh = {
      border = vim.g.border,
    },
    -- Configuration for the floating keymaps help window
    keymaps_help = {
      border = vim.g.border,
    },
  },
}
