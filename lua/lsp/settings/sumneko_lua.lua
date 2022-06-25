-- sumneko-lua language server

local M = {}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

M.setup = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          enable = true,
          globals = {
            'after_each',
            'before_each',
            'describe',
            'it',
            'pending',
            'teardown',
            'vim',
          },
          disable = { 'lowercase-global' },
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = vim.o.expandtab and 'space' or 'tab',
            indent_size = tostring(vim.o.shiftwidth),
            max_line_length = tostring(vim.o.textwidth),
            -- quote_style = 'single',
            trim_trailing_whitespace = 'true',
            insert_final_newline = 'true',
            keep_line_after_do_statement = 'minLine:1',
            keep_line_after_expression_statement = 'maxLine:1',
            keep_line_after_for_statement = 'minLine:1',
            keep_line_after_function_define_statement = 'maxLine:1',
            keep_line_after_if_statement = 'minLine:1',
            keep_line_after_local_or_assign_statement = 'keepLine',
            keep_line_after_repeat_statement = 'minLine:1',
            keep_line_after_while_statement = 'minLine:1',
            keep_one_space_between_call_args_and_parentheses = 'false',
            keep_one_space_between_namedef_and_attribute = 'true',
            keep_one_space_between_table_and_bracket = 'true',
            max_continuous_line_distance = '0',
            table_append_expression_no_space = 'true',
          },
        },
        workspace = {
          maxPreload = 2000,
          preloadFileSize = 50000,
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

return M
