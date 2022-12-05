-- jdtls: Java eclipse language server
local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then
  vim.notify('nvim-jdtls: package not found, please install it first', vim.log.levels.ERROR)
  return
end

local env = {
  HOME = vim.loop.os_homedir(),
  XDG_CACHE_HOME = os.getenv('XDG_CACHE_HOME'),
  JDTLS_JVM_ARGS = os.getenv('JDTLS_JVM_ARGS'),
}

local path = require('lspconfig.util').path

local function get_cache_dir()
  return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or path.join(env.HOME, '.cache')
end

local function get_jdtls_cache_dir()
  return path.join(get_cache_dir(), 'jdtls')
end

local function get_jdtls_config_dir()
  return path.join(get_jdtls_cache_dir(), 'config')
end

local function get_jdtls_workspace_dir()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  return path.join(get_jdtls_cache_dir(), 'workspaces', project_name)
end

local function get_jdtls_jvm_args()
  local args = {}
  for a in string.gmatch((env.JDTLS_JVM_ARGS or ''), '%S+') do
    local arg = string.format('--jvm-arg=%s', a)
    table.insert(args, arg)
  end
  return unpack(args)
end

-- local root_dir = { '.gradlew', '.git', 'mvnw', 'build.xml ', 'pom.xml' }

local capabilities = require('lsp.capabilities')
local default_attach = require('lsp.attach')

local default_config = require('lspconfig').jdtls.document_config.default_config

local function on_attach(client, bufnr)
  require('jdtls.setup').add_commands()
  default_attach(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = 'auto' })
  local map = vim.keymap.set
  map({ 'n' }, '<A-o>', "<Cmd>lua require('jdtls').organize_imports()<CR>", { remap = false })
  map({ 'n', 'v' }, 'crv', "<Esc><Cmd>lua require('jdtls').extract_variable()<CR>", { remap = false })
  map({ 'n', 'v' }, 'crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { remap = false })
  map({ 'n' }, 'crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { remap = false })

  -- If using nvim-dap
  -- This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
  map({ 'n' }, '<leader>df', "<Cmd>lua require('jdtls').test_class()<CR>", { remap = false })
  map({ 'n' }, '<leader>dn', "<Cmd>lua require('jdtls').test_nearest_method()<CR>", { remap = false })
end

local config = {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    'jdtls',
    '-configuration',
    get_jdtls_config_dir(),
    '-data',
    get_jdtls_workspace_dir(),
    get_jdtls_jvm_args(),
  },
  filetypes = default_config.filetypes,
  root_dir = default_config.root_dir(),
  flags = {
    allow_incremental_sync = true,
    server_side_fuzzy_completion = true,
  },
  settings = {
    java = {
      signatureHelp = {
        enabled = true,
      },
      completion = {
        favoriteStaticMembers = {},
        importOrder = {
          'javax',
          'java',
          'com',
          'org',
        },
      },
      saveActions = {
        organizeImports = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      format = {
        enabled = true,
        comments = {
          enabled = false,
        },
        settings = {
          profile = 'GoogleStyle',
          url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
        },
      },
      codeGeneration = {
        tostring = {
          listArrayContents = true,
          skipNullValues = true,
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        useBlocks = true,
        hashCodeEquals = {
          useInstanceof = true,
          useJava7Objects = true,
        },
        generateComments = true,
        insertLocation = true,
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },
    },
    configuration = {
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- And search for `interface RuntimeOption`
      -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
      runtimes = {
        {
          name = 'JavaSE-11',
          path = '/usr/lib/jvm/java-11-openjdk-amd64/',
        },
        {
          name = 'JavaSE-17',
          path = '/usr/lib/jvm/java-17-openjdk-amd64/',
        },
      },
    },
  },
  init_options = {
    bundles = {},
    workspace = get_jdtls_workspace_dir(),
  },
}

local group = vim.api.nvim_create_augroup('JdtlsConfiguration', {})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Attach jdtls to java filetypes',
  group = group,
  pattern = 'java',
  callback = function()
    jdtls.start_or_attach(config)
  end,
})

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   desc = 'Organize import on save',
--   group = group,
--   pattern = '*.java',
--   callback = function()
--     local params = vim.lsp.util.make_range_params()
--     local bufnr = vim.api.nvim_get_current_buf()
--     params.context = {
--       diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
--     }
--     local result, err = vim.lsp.buf_request_sync(0, 'java/organizeImports', params)
--     if err then
--       vim.notify('Error on organize imports: ' .. err, vim.log.levels.ERROR)
--       return
--     end
--     result = vim.tbl_values(result)
--     if result and result[1].result then
--       vim.lsp.util.apply_workspace_edit(result[1].result, 'utf-16')
--     end
--   end,
-- })
