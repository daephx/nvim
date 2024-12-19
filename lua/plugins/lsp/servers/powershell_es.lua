-- powershell_es: Language-server configuration
-- https://github.com/PowerShell/PowerShellEditorServices

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Disable highlighting for powershell_es semantic tokens",
  group = vim.api.nvim_create_augroup("LspAttach_PowerShellES", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "powershell_es" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

return {
  init_options = {
    enableProfileLoading = false,
  },
  settings = {
    powershell = {
      codeFormatting = {
        Preset = "Stroustrup",
        addWhitespaceAroundPipe = true,
        alignPropertyValuePairs = false,
        autoCorrectAliases = true,
        avoidSemicolonsAsLineTerminators = true,
        ignoreOneLineBlock = true,
        newLineAfterCloseBrace = true,
        newLineAfterOpenBrace = true,
        openBraceOnSameLine = true,
        pipelineIndentationStyle = "IncreaseIndentationForFirstPipeline",
        useCorrectCasing = true,
        whitespaceAfterSeparator = true,
        whitespaceAroundOperator = true,
        whitespaceBeforeOpenParen = true,
        whitespaceBetweenParameters = false,
      },
      scriptAnalysis = {
        settingsPath = "PSScriptAnalyzerSettings.psd1",
      },
    },
  },
}
