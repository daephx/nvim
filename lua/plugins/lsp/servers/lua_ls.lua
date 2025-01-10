-- lua_ls: language server configuration
-- https://github.com/LuaLS/lua-language-server

---@type config.lsp.ClientConfig
return {
  settings = {
    Lua = {
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
        disable = {
          "incomplete-signature-doc",
          "lowercase-global",
        },
        globals = { "vim" },
        unusedLocalExclude = { "_*" },
      },
      format = {
        enable = false,
        defaultConfig = {
          indent_size = "2",
          continuation_indent = "2",
          indent_style = "space",
          max_line_length = "80",
          quote_style = "double",
          insert_final_newline = "true",
          trim_trailing_whitespace = "true",
        },
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
