-- Commands

-- Typo commands
vim.cmd.cnoreabbrev({ "BD", "bd" })
vim.cmd.cnoreabbrev({ "Bd", "bd" })
vim.cmd.cnoreabbrev({ "bD", "bd" })

vim.cmd.cnoreabbrev({ "E", "e" })

vim.cmd.cnoreabbrev({ "SO", "so" })
vim.cmd.cnoreabbrev({ "So", "so" })
vim.cmd.cnoreabbrev({ "sO", "so" })

vim.cmd.cnoreabbrev({ "Q", "q" })
vim.cmd.cnoreabbrev({ "QA", "qa" })
vim.cmd.cnoreabbrev({ "Qa", "qa" })
vim.cmd.cnoreabbrev({ "qA", "qa" })

vim.cmd.cnoreabbrev({ "SO", "so" })
vim.cmd.cnoreabbrev({ "So", "so" })
vim.cmd.cnoreabbrev({ "sO", "so" })

vim.cmd.cnoreabbrev({ "W", "w" })
vim.cmd.cnoreabbrev({ "WQ", "wq" })
vim.cmd.cnoreabbrev({ "Wq", "wq" })
vim.cmd.cnoreabbrev({ "wQ", "wq" })

vim.cmd.cnoreabbrev({ "X", "x" })
vim.cmd.cnoreabbrev({ "XA", "xa" })
vim.cmd.cnoreabbrev({ "Xa", "xa" })
vim.cmd.cnoreabbrev({ "xA", "xa" })

-- Delete buffer without closing window
vim.cmd.cnoreabbrev({ "bdd", "bn|bd#" })

-- Plenary reload module
vim.api.nvim_create_user_command("R", function(ev)
  local name = ev.args
  if name == "" then
    name = vim.fn.expand("%:."):gsub("%.lua", "")
  end
  local plenary_ok, _ = pcall(require, "plenary")
  if plenary_ok then
    require("plenary.reload").reload_module(name, true)
  else
    package.loaded[name] = nil
  end
  local _, module = pcall(require, name)
  return module
end, {
  nargs = "?",
  complete = function()
    local modules = {}
    for key, _ in pairs(package.loaded) do
      table.insert(modules, key)
    end
    return modules
  end,
})
