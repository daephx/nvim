-- lua_ls: language server configuration

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      completion = { callSnippet = "Replace" },
      diagnostics = {
        enable = true,
        groupSeverity = {
          strong = "Warning",
          strict = "Warning",
        },
        groupFileStatus = {
          ["ambiguity"] = "Opened",
          ["await"] = "Opened",
          ["codestyle"] = "None",
          ["duplicate"] = "Opened",
          ["global"] = "Opened",
          ["luadoc"] = "Opened",
          ["redefined"] = "Opened",
          ["strict"] = "Opened",
          ["strong"] = "None",
          -- ["strong"] = "Opened",
          ["type-check"] = "Opened",
          ["unbalanced"] = "Opened",
          ["unused"] = "Opened",
        },
        unusedLocalExclude = { "_*" },
        disable = { "lowercase-global" },
        globals = {
          "after_each",
          "before_each",
          "describe",
          "it",
          "pending",
          "teardown",
          "vim",
        },
      },
      format = {
        enable = false,
        defaultConfig = {
          indent_size = "2",
          indent_style = "space",
          insert_final_newline = "true",
          max_line_length = "80",
          quote_style = "double",
          trim_trailing_whitespace = "true",
        },
      },
      workspace = {
        maxPreload = 100000,
        preloadFileSize = 10000,
        checkThirdParty = false,
        library = {
          -- Add default runtime files to library
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,

          -- Add user config to library
          [vim.fn.stdpath("config") .. "/lua"] = true,

          -- Add lazy plugin directory
          [vim.fn.stdpath("data") .. "/lazy"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
