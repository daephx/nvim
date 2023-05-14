local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local telescope = require("telescope")

local conf = require("telescope.config").values

local dotfiles_list = function(opts)
  local dir = opts.path or ""
  print("dir:", dir)
  local list = {}
  local p = io.popen("rg --files --hidden " .. dir)
  if p then
    for file in p:lines() do
      table.insert(list, file)
    end
  end

  local dotfiles_path = os.getenv("DOTFILES") or "~/.dotfiles"
  local dotfiles = io.popen("rg --files " .. dotfiles_path)
  if dotfiles then
    for file in dotfiles:lines() do
      table.insert(list, file)
    end
  end
  return list
end

local dotfiles = function(opts)
  opts = opts or {}
  local results = dotfiles_list(opts)

  pickers
    .new(opts, {
      prompt_title = "Dotfiles",
      cwd = opts.path,
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

return telescope.register_extension({ exports = { dotfiles = dotfiles } })
