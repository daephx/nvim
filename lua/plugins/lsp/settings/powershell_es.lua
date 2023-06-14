-- powershell_es: Language-server configuration
-- https://github.com/PowerShell/PowerShellEditorServices

return {
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
