local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local telescope = require("telescope")

local conf = require("telescope.config").values

---@param opts table
local vimfiles_list = function(opts)
  local dir = opts.path or ""
  local list = {}
  local p = io.popen("rg --files --hidden " .. dir)
  if p then
    for file in p:lines() do
      table.insert(list, file)
    end
  end

  local nvim_conf = vim.fn.stdpath("config")
  local vimfiles = io.popen("rg --files " .. nvim_conf)
  if vimfiles then
    for file in vimfiles:lines() do
      table.insert(list, file)
    end
  end

  return list
end

---@param opts table
local vimfiles = function(opts)
  opts = opts or {}
  local results = vimfiles_list(opts)

  pickers
    .new(opts, {
      prompt_title = "Neovim",
      cwd = vim.fn.stdpath("config"),
      hidden = true,
      finder = finders.new_table({
        results = results,
        entry_maker = make_entry.gen_from_file(opts),
      }),
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
    })
    :find()
end

return telescope.register_extension({ exports = { vimfiles = vimfiles } })
