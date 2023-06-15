std = "luajit"

-- Rerun tests only if their modification time changed
cache = true

-- Don't report unused self arguments of methods
self = false

-- Global objects
globals = {
  "map",
  "vim",
}

-- Ignore rules
ignore = {
  "212/_.*", -- Unused argument, allow callback function vars with "_arg" prefix
  "631", -- Ignore max line length
}
