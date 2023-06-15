<div align="center">
<h1>Neovim Configuration</h1>

[![Neovim version](https://img.shields.io/github/v/release/neovim/neovim?include_prereleases&style=for-the-badge&label=Neovim&logo=neovim&labelColor=000000)](https://github.com/neovim/neovim/releases/tag/nightly)
[![Actions](https://img.shields.io/github/actions/workflow/status/daephx/nvim/lint.yml?branch=main&label=CI&style=for-the-badge&labelColor=000000)](https://github.com/daephx/nvim/actions)
[![Code size](https://img.shields.io/github/languages/code-size/daephx/nvim?label=Size&style=for-the-badge&labelColor=000000)](#)
[![Top languages](https://img.shields.io/github/languages/top/daephx/nvim?style=for-the-badge&labelColor=000000&logo=lua&logoColor=blue)](https://github.com/daephx/nvim/search?l=lua)
[![License](https://img.shields.io/github/license/daephx/nvim?&label=License&style=for-the-badge&color=8937dd&labelColor=000000)](https://github.com/daephx/nvim/blob/main/LICENSE)
<br/>
[![Linux](https://img.shields.io/badge/Linux-%23.svg?logo=linux&style=for-the-badge&color=000000&logoColor=yellow)](https://en.wikipedia.org/wiki/Linux)
[![MacOS](https://img.shields.io/badge/MacOS-%23.svg?logo=apple&style=for-the-badge&color=000000&logoColor=white)](https://en.wikipedia.org/wiki/MacOS)
[![Windows](https://img.shields.io/badge/Windows-%23.svg?logo=windows11&style=for-the-badge&color=000000&logoColor=blue)](https://en.wikipedia.org/wiki/Microsoft_Windows)
<br/>

<sup>• Backward compatibility is NOT guaranteed! •</sup>
<img src="https://github.com/daephx/nvim/assets/36192863/597acb0a-ee6f-4aef-a380-5329d8df6f99"/>

</div>

## Introduction

Personal neovim configuration that uses
[Lazy](https://github.com/folke/lazy.nvim) and
[Mason](https://github.com/williamboman/mason.nvim) for dependency management.

You can find all plugin specifications within: `lua/plugins`.

## Installation

**NOTE**: Before installing, be sure backup/move any existing config!

Ensure [Neovim](https://github.com/neovim/neovim) is properly installed and
clone this repository to one of the following locations.

- Unix: `~/.config/nvim`
- Windows: `~\AppData\Local\nvim`

```bash
# Linux and MacOS
$ git clone https://github.com/daephx/nvim.git ~/.config/nvim

# Windows
$ git clone https://github.com/daephx/nvim.git ~\AppData\Roaming\nvim
```

Then run `nvim` which will kick-off the lazy bootstrap process and install all
the required plugins and treesitter parsers.

If there are any errors? First restart `nvim` to ensure all the newly installed
packages are properly loaded. If that doesn't work try running the
`:checkhealth` command. You can also raise an issue or pull request, as they
would be greatly appreciated.

### Fonts

For a better visual experience, install and configure your terminal to use
patched font family from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts).

Recommended:

- [CascadiaCode](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip)
- [FiraCode](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip)
- [Hack](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip)

Or you can configure your system to handle symbols via
[Font Substitution & Fallback](https://github.com/ryanoasis/nerd-fonts/wiki/Font-Substitution-&-Fallback)

### Compatibility (Optional)

For plugin compatibility with other languages, you should install the following
packages.

Python client and plugin host: [pynvim](https://github.com/neovim/pynvim)

```bash
pip install pynvim
```

Node client and plugin host:
[node-client](https://github.com/neovim/node-client)

```bash
npm i -g neovim
```

## Folder Structure

```plain
nvim/                 # Neovim config directory
├─ after/
│  ├─ colors/         # Override builtin colorschemes
│  │  ├─ default.lua
│  │  └─ habamax.lua
│  ├─ ftplugin/       # Filetype specific options
│  │  └─ lua.lua
│  └─ queries/        # Treesitter extended queries
│     └─ lua/
├─ lua/
│  ├─ config/         # Editor options and commands
│  ├─ plugins/        # Plugin specifications/configs
│  │  ├─ colors/      # Colorscheme plugins
│  │  ├─ dap/         # Debug adapter plugins
│  │  ├─ lsp/         # Language server plugins
│  │  └─ cmp.lua      # Code completion plugins
│  └─ snippets/       # Dynamic lua snippets
│     ├─ all.lua
│     └─ lua.lua
├─ snippets/          # Lsp compatible snippets
│  ├─ package.json    # Snippets package manifest
│  ├─ all.json
│  └─ lua.json
└─ templates/         # Templates directory
   └─ lua.skel        # New lua file skeleton
```
