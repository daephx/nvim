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
