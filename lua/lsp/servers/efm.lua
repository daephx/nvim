-- EFM | General purpose language server
-- Throw an error if dependencies not available
if not vim.fn.executable('go') then
  error('Go binary cannot be located in PATH: Is it installed?')
  return
end

--- Golang ---

local gofmt = {
  formatCommand = 'gofmt',
  formatStdin = true,
}

--- Lua ---

local luafmt = {
  formatCommand = table.concat({
    'lua-format',
    '-i',
    '--no-keep-simple-function-one-line',
    '--no-break-after-operator',
    '--column-limit=' .. (vim.o.textwidth or 80),
    '--indent-width=' .. (vim.o.shiftwidth or 80),
    '--break-after-table-lb',
  }, ' '),
  formatStdin = true,
}

--- Python ---

-- local py_main_env = vim.fn.glob("$CONDA_ROOT/envs/main")

local black = {
  formatCommand = 'black --quiet --line-length=102 -',
  formatStdin = true,
}
local isort = {
  formatCommand = 'isort --quite --stdout --profile black -',
  formatStdin = true,
}

local docformatter = {
  formatCommand = 'docformatter',
  formatStdin = true,
}

local flake8 = {
  lintCommand = table.concat({
    'flake8',
    '--max-line-length',
    '160',
    '--format',
    "'%(path)s:%(row)d:%(col)d:",
    '%(code)s',
    '%(code)s',
    "%(text)s'",
    '--stdin-display-name',
    '${INPUT}',
    '-',
  }, ' '),
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = { '%f:%l:%c: %t%n%n%n %m' },
  lintSource = 'flake8',
}

--- Rust ---

local rustfmt = {
  formatCommand = 'rustfmt',
  formatStdin = true,
}

--- JS/TS/Frontend ---

local prettier = {
  formatCommand = 'prettier',
  formatStdin = true,
}

local eslint = {
  formatCommand = 'eslint',
  formatStdin = true,
}

--- EFM ---

local M = {}

M.setup = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    filetypes = { 'python', 'cpp', 'lua', 'go' },
    languages = {
      lua = { luafmt },
      go = { gofmt },
      rust = { rustfmt },
      python = { black, isort, flake8 },
      typescript = { prettier, eslint },
      javascript = { prettier, eslint },
      typescriptreact = { prettier, eslint },
      javascriptreact = { prettier, eslint },
      yaml = { prettier },
      json = { prettier },
      html = { prettier },
      scss = { prettier },
      css = { prettier },
      markdown = { prettier },
    },
    settings = {
      rootMarkers = {
        '.git/',
        '.venv/',
        'Gem.lock',
        'README.md',
        'lerna.json',
        'requirements.txt',
        'yarn.lock',
      },
    },
  }
end

return M
