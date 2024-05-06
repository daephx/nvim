<div align="center">
<h1>Neovim Configuration</h1>

[![Neovim](https://img.shields.io/github/v/release/neovim/neovim?include_prereleases&style=for-the-badge&label=Neovim&logo=neovim&labelColor=000000)](https://github.com/neovim/neovim/releases/tag/nightly)
[![Actions](https://img.shields.io/github/actions/workflow/status/daephx/nvim/ci.yml?branch=main&label=CI&style=for-the-badge&logo=githubactions&labelColor=000000)](https://github.com/daephx/nvim/actions)
[![Languages](https://img.shields.io/github/languages/top/daephx/nvim?style=for-the-badge&labelColor=000000&logo=lua&logoColor=blue)](https://github.com/daephx/nvim/search?l=lua)
[![Size](https://img.shields.io/github/languages/code-size/daephx/nvim?label=Size&style=for-the-badge&labelColor=000000)](#)
[![License](https://img.shields.io/github/license/daephx/nvim?&label=License&style=for-the-badge&color=8937dd&labelColor=000000)](https://github.com/daephx/nvim/blob/main/LICENSE)
<br/>
[![Linux](https://img.shields.io/badge/Linux-%23.svg?logo=linux&style=for-the-badge&color=000000&logoColor=yellow)](https://en.wikipedia.org/wiki/Linux)
[![macOS](https://img.shields.io/badge/MacOS-%23.svg?logo=apple&style=for-the-badge&color=000000&logoColor=white)](https://en.wikipedia.org/wiki/MacOS)
[![Windows](https://img.shields.io/badge/Windows-%23.svg?logo=windows11&style=for-the-badge&color=000000&logoColor=blue)](https://en.wikipedia.org/wiki/Microsoft_Windows)
<br/>
<img src="https://github.com/daephx/nvim/assets/36192863/597acb0a-ee6f-4aef-a380-5329d8df6f99"/>

</div>

## Introduction

Personal Neovim configuration that uses
[Lazy](https://github.com/folke/lazy.nvim) and
[Mason](https://github.com/williamboman/mason.nvim) for dependency management.

You can find all plugin specifications within `lua/plugins`.

## Dependencies

> NOTE: This configuration primarily targets Neovim nightly but aims to be
> compatible with the latest stable release. Be sure the version provided by
> your package manager is up-to-date, or see one of the other available methods
> for installation: <https://github.com/neovim/neovim/wiki/Installing-Neovim>

External dependencies are kept to a minimum. However, some plugins do require
extra packages to be installed.

Here is a list of plugin dependencies:

| Plugin                                                                   | Dependencies                                                                            |
| :----------------------------------------------------------------------- | :-------------------------------------------------------------------------------------- |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                          | [git](https://git-scm.com/)                                                             |
| [mason.nvim](https://github.com/williamboman/mason.nvim)                 | `curl`, `wget`, `gzip`, `tar`, `unzip`                                                  |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)       | [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep)   |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | [npm](https://www.npmjs.com/)                                                           |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)    | [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) |

### Mason

Many packages provided by [Mason](https://github.com/williamboman/mason.nvim)
either install pre-compiled binaries or utilize a given language for its
runtime. It's recommended to install any relevant tools for the stack you're
targeting, be that Go, Rust, or Web development.<br> However, there are some
exceptions...

Primary [node.js](https://nodejs.org), since many language servers and tools are
implemented in JavaScript or TypeScript.

Some of the packages that require node:
[bashls](https://github.com/bash-lsp/bash-language-server),
[cssls](https://github.com/microsoft/vscode-css-languageservice),
[html-lsp](https://github.com/microsoft/vscode-html-languageservice),
[jsonls](https://github.com/microsoft/vscode-json-languageservice),
[markdownlint](https://github.com/igorshubovych/markdownlint-cli),
[prettier](https://github.com/prettier/prettier),
[pyright](https://github.com/microsoft/pyright),
[yamlls](https://github.com/redhat-developer/yaml-language-server)

### Fonts & Symbols

For a better visual experience, install and configure your terminal to use a
patched font family from
[nerd-fonts](https://github.com/ryanoasis/nerd-fonts)<br> Or, configure your
system to handle symbols via
[Font Substitution & Fallback](https://github.com/ryanoasis/nerd-fonts/wiki/Font-Substitution-&-Fallback).

Recommended:
[CascadiaCode](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip),
[FiraCode](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip),
[Hack](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip)

### Compatibility (Optional)

For plugins that are built in other languages, you may need to install one of
the following compatibility clients:

| Language | Client/Plugin-host                                   |
| :------- | :--------------------------------------------------- |
| Node     | [node-client](https://github.com/neovim/node-client) |
| Python   | [pynvim](https://github.com/neovim/pynvim)           |
| Ruby     | [neovim-ruby](https://github.com/neovim/neovim-ruby) |

## Installation

Ensure Neovim is properly installed, and clone this repository to your
platform's configuration path.<br> Then simply run `nvim` to kick off the
bootstrap process, which will install all the required plugins and parsers!

```bash
# Linux and MacOS
git clone https://github.com/daephx/nvim.git ~/.config/nvim

# Windows
git clone https://github.com/daephx/nvim.git ~\AppData\Local\nvim
```

If you already have your own set of configuration files, you can run this
configuration alongside your own by cloning to a separate directory and
launching Neovim after defining the `NVIM_APPNAME` environment variable.

```bash
git clone https://github.com/daephx/nvim.git ~/.config/nvim-daephx
NVIM_APPNAME=nvim-daephx nvim
```

On Unix, you can use the Makefile to create a temporary instance: `make run`

This will overwrite the XDG environment variables just for that session,
creating a temporary home directory where Neovim will run for storing plugins,
parsers and Neovim data.

Afterwords, you can manually delete the directory or use: `make clean`

**What should I do if I'm getting errors?**

- Verify that your Neovim version is up-to-date! `stable` / `nightly`
- Try restarting `nvim` to ensure the necessary plugins are properly loaded.
- Run `:checkhealth` to check for any errors, such as missing dependencies.
- Finally, check for or feel free to open an issue regarding your problem.

## Folder Structure

```plain
nvim/                 # Neovim config directory
├─ after/
│  ├─ colors/         # Override builtin colorschemes
│  │  ├─ default
│  │  └─ habamax
│  ├─ ftplugin/       # Filetype specific options
│  │  ├─ lua.lua
│  │  └─ vim.lua
│  └─ queries/        # Treesitter extended queries
│     ├─ lua/
│     └─ vim/
├─ lua/
│  ├─ config/         # Editor options and commands
│  ├─ plugins/        # Plugin specifications/configs
│  │  ├─ colors/      # Colorscheme plugins
│  │  ├─ cmp          # Code completion plugins
│  │  ├─ dap          # Debug adapter plugins
│  │  └─ lsp          # Language server plugins
│  └─ snippets/       # Luasnip compatible snippets
│     ├─ global
│     └─ lua
├─ snippets/          # LSP compatible snippets
│  ├─ package.json    # Snippets package manifest
│  ├─ global
│  └─ lua
└─ templates/         # Templates directory
   └─ lua.skel        # New lua file skeleton
```
