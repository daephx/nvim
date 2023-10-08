<div align="center">
<h1>Neovim Configuration</h1>

[![Neovim version](https://img.shields.io/github/v/release/neovim/neovim?include_prereleases&style=for-the-badge&label=Neovim&logo=neovim&labelColor=000000)](https://github.com/neovim/neovim/releases/tag/nightly)
[![Top languages](https://img.shields.io/github/languages/top/daephx/nvim?style=for-the-badge&labelColor=000000&logo=lua&logoColor=blue)](https://github.com/daephx/nvim/search?l=lua)
[![Code size](https://img.shields.io/github/languages/code-size/daephx/nvim?label=Size&style=for-the-badge&labelColor=000000)](#)
[![Actions](https://img.shields.io/github/actions/workflow/status/daephx/nvim/lint.yml?branch=main&label=CI&style=for-the-badge&labelColor=000000)](https://github.com/daephx/nvim/actions)
[![License](https://img.shields.io/github/license/daephx/nvim?&label=License&style=for-the-badge&color=8937dd&labelColor=000000)](https://github.com/daephx/nvim/blob/main/LICENSE)
<br/>
[![Linux](https://img.shields.io/badge/Linux-%23.svg?logo=linux&style=for-the-badge&color=000000&logoColor=yellow)](https://en.wikipedia.org/wiki/Linux)
[![MacOS](https://img.shields.io/badge/MacOS-%23.svg?logo=apple&style=for-the-badge&color=000000&logoColor=white)](https://en.wikipedia.org/wiki/MacOS)
[![Windows](https://img.shields.io/badge/Windows-%23.svg?logo=windows11&style=for-the-badge&color=000000&logoColor=blue)](https://en.wikipedia.org/wiki/Microsoft_Windows)
<br/>
<img src="https://github.com/daephx/nvim/assets/36192863/597acb0a-ee6f-4aef-a380-5329d8df6f99"/>

</div>

## Introduction

Personal neovim configuration that uses
[Lazy](https://github.com/folke/lazy.nvim) and
[Mason](https://github.com/williamboman/mason.nvim) for dependency management.

You can find all plugin specifications within: `lua/plugins`.

## Installation

Ensure [Neovim](https://github.com/neovim/neovim) is properly installed and
clone this repository to your platforms configuration path.<br> Then simply run
`nvim` to kick-off the bootstrap process, which will install all the required
plugins and parsers!

```bash
# Linux and MacOS
git clone https://github.com/daephx/nvim.git ~/.config/nvim

# Windows
git clone https://github.com/daephx/nvim.git ~\AppData\Local\nvim
```

If you already have your own set of config files? You can run this config
align-side your own by cloning to a separate directory and launching nvim after
defining the `NVIM_APPNAME` environment variable.

```bash
git clone https://github.com/daephx/nvim.git ~/.config/nvim-daephx
NVIM_APPNAME=nvim-daephx nvim
```

On Unix, you can also use the Makefile to create a temporary instance:
`make run`

**If there are any errors?**

- Verify your neovim version is up-to-date! `stable` / `nightly`
- Try restarting `nvim` to ensure all plugins are properly loaded.
- Or, run the `:checkhealth` command to check for any outstanding errors.
- Finally, if you don't see an issues or pull request regarding your problem,
  feel free to open a new one!

### Fonts & Symbols

For a better visual experience, install and configure your terminal to use
patched font family from
[nerd-fonts](https://github.com/ryanoasis/nerd-fonts)<br> Or, configure your
system to handle symbols via
[Font Substitution & Fallback](https://github.com/ryanoasis/nerd-fonts/wiki/Font-Substitution-&-Fallback).

Recommended:
[CascadiaCode](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip),
[FiraCode](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip),
[Hack](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip)

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
│  │  ├─ default
│  │  └─ habamax
│  ├─ ftplugin/       # Filetype specific options
│  │  ├─ lua
│  │  └─ vim
│  └─ queries/        # Treesitter extended queries
│     ├─ lua
│     └─ vim
├─ lua/
│  ├─ config/         # Editor options and commands
│  ├─ plugins/        # Plugin specifications/configs
│  │  ├─ colors/      # Colorscheme plugins
│  │  ├─ cmp          # Code completion plugins
│  │  ├─ dap          # Debug adapter plugins
│  │  └─ lsp          # Language server plugins
│  └─ snippets/       # Luasnip compatible snippets
│     ├─ all.lua
│     └─ lua.lua
├─ snippets/          # LSP compatible snippets
│  ├─ all.json
│  ├─ lua.json
│  └─ package.json    # Snippets package manifest
└─ templates/         # Templates directory
   └─ lua.skel        # New lua file skeleton
```
