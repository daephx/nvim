-- hex.nvim | hex editing done right
-- https://github.com/RaafatTurki/hex.nvim

---@type LazyPluginSpec
return {
  "RaafatTurki/hex.nvim",
  cmd = { "HexAssemble", "HexDump", "HexToggle" },
  event = { "BufReadPre", "BufNewFile" },
  config = true,
}
