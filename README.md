<div align="center">
<h1>Neovim Configuration</h1>

[![Neovim](https://img.shields.io/github/v/release/neovim/neovim?style=for-the-badge&label=Neovim&logo=neovim&labelColor=000000)](https://github.com/neovim/neovim)
[![Actions](https://img.shields.io/github/actions/workflow/status/daephx/nvim/ci.yml?branch=main&label=CI&style=for-the-badge&logo=githubactions&labelColor=000000)](https://github.com/daephx/nvim/actions)
[![Languages](https://img.shields.io/github/languages/top/daephx/nvim?style=for-the-badge&labelColor=000000&logo=lua&logoColor=blue)](https://github.com/daephx/nvim/search?l=lua)
[![Size](https://img.shields.io/github/languages/code-size/daephx/nvim?label=Size&style=for-the-badge&labelColor=000000)](#)
[![License](https://img.shields.io/github/license/daephx/nvim?&label=License&style=for-the-badge&color=8937dd&labelColor=000000)](https://github.com/daephx/nvim/blob/main/LICENSE)
<br/>
[![Linux](https://img.shields.io/badge/Linux-%23.svg?logo=linux&style=for-the-badge&color=000000&logoColor=yellow)](https://en.wikipedia.org/wiki/Linux)
[![macOS](https://img.shields.io/badge/MacOS-%23.svg?logo=apple&style=for-the-badge&color=000000&logoColor=white)](https://en.wikipedia.org/wiki/MacOS)
[![Windows](https://img.shields.io/badge/Windows-%23.svg?logo=windows11&style=for-the-badge&color=000000&logoColor=blue)](https://en.wikipedia.org/wiki/Microsoft_Windows)
<br/>
<img alt="screenshot" src="https://github.com/daephx/nvim/assets/36192863/597acb0a-ee6f-4aef-a380-5329d8df6f99"/>

</div>

## Overview

Personal Neovim configuration built around
[Lazy](https://github.com/folke/lazy.nvim) and
[Mason](https://github.com/williamboman/mason.nvim). All plugin specs live in
`lua/plugins/`.

## Requirements

- **Neovim** – nightly recommended, but stable should work (ensure it’s recent)
- **Git** – for cloning and lazy.nvim
- **Optional tools** (pickers use): `fd` and `ripgrep`
- **Node.js** – required by many Mason LSPs and `markdown-preview.nvim`
- **Nerd Font** (recommended) – for icons; pick any from
  [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) (e.g., JetBrainsMono,
  FiraCode, Hack)

## Installation

Clone the repo to your Neovim config path, then run `nvim` – Lazy will
automatically install all plugins.

```bash
# Linux / macOS
git clone https://github.com/daephx/nvim.git ~/.config/nvim

# Windows
git clone https://github.com/daephx/nvim.git ~\AppData\Local\nvim
```

To test this config without overwriting your own, clone to a different folder
and use `NVIM_APPNAME`:

```bash
git clone https://github.com/daephx/nvim.git ~/.config/nvim-daephx
NVIM_APPNAME=nvim-daephx nvim
```

## Troubleshooting

- Update Neovim to the latest stable/nightly.
- Restart `nvim` to ensure plugins load.
- Run `:checkhealth` to spot missing dependencies.
- [Open an issue](https://github.com/daephx/nvim/issues) if problems persist.
