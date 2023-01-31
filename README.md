<div align="center">
<h1>Neovim Configuration</h1>
<a href="https://github.com/neovim/neovim/releases/tag/nightly" target="_blank" rel="noopener noreferrer">
<img alt="Neovim version" src="https://img.shields.io/badge/Neovim-0.9.0--dev-blueviolet.svg?style=for-the-badge&logo=Neovim&labelColor=000000&logoColor=green"/>
</a>
<a href="https://github.com/daephx/nvim/actions" target="_blank" rel="noopener noreferrer">
<img alt="Checks" src="https://img.shields.io/github/checks-status/daephx/nvim/main?style=for-the-badge&labelColor=000000&label=CI"/>
</a>
<a href="#">
<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/daephx/nvim?label=Size&style=for-the-badge&labelColor=000000">
</a>
<a href="https://github.com/daephx/nvim/search?l=lua" target="_blank" rel="noopener noreferrer">
<img alt="Top languages" src="https://img.shields.io/github/languages/top/daephx/nvim?style=for-the-badge&labelColor=000000&logo=lua&logoColor=blue"/>
</a>
<a href="https://github.com/daephx/nvim/blob/master/LICENSE" target="_blank" rel="noopener noreferrer">
<img alt="License" src="https://img.shields.io/github/license/daephx/nvim?&label=License&style=for-the-badge&color=8937dd&labelColor=000000"/>
</a>
<br/>
<a href="https://en.wikipedia.org/wiki/Linux" target="_blank" rel="noopener noreferrer">
<img alt="Linux" src="https://img.shields.io/badge/Linux-%23.svg?logo=linux&style=for-the-badge&color=000000&logoColor=yellow"/>
</a>
<a href="https://en.wikipedia.org/wiki/MacOS" target="_blank" rel="noopener noreferrer">
<img alt="MacOS" src="https://img.shields.io/badge/MacOS-%23.svg?logo=apple&style=for-the-badge&color=000000&logoColor=white"/>
</a>
<a href="https://en.wikipedia.org/wiki/Microsoft_Windows" target="_blank" rel="noopener noreferrer">
<img alt="Windows" src="https://img.shields.io/badge/Windows-%23.svg?logo=windows11&style=for-the-badge&color=000000&logoColor=blue"/>
</a>
</br>
<sup>&#149; Uses Neovim nightly. No backward compatibility guaranteed! &#149;</sup>
<img src="https://user-images.githubusercontent.com/36192863/208231941-b54d0d70-0d46-4ad0-89ed-398917a2bd72.gif"></img>
</div>

## Introduction

Personal neovim configuration that uses
[Lazy](https://github.com/folke/lazy.nvim) and
[Mason](https://github.com/williamboman/mason.nvim) for dependency management.

For more detailed plugin list, see file `lua/plugins/init.lua`

## Installation

**NOTE**: Before installing, be sure to move or delete any existing config
folders:

- Unix: `~/.config/nvim`
- Windows: `~\AppData\Local\nvim`

Ensure [Neovim](https://github.com/neovim/neovim) is properly installed using
your preferred package manager and clone this repository to the specified
location.

```sh
# Linux and MacOS
$ git clone https://github.com/daephx/nvim.git ~/.config/nvim

# Windows
$ git clone https://github.com/daephx/nvim.git ~\AppData\Roaming\nvim
```

After cloning this repository, run `nvim`. The lazy bootstrap process will clone
and build all missing plugins, including treesitter parsers.

If there are any errors: run `:checkhealth` or restart `nvim` to ensure all
packages are properly loaded. If that doesn't work, an issue or pull request
would be greatly appreciated.

### Fonts

For a better visual experience, install and configure your terminal to use
patched font family from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts).

Recommended:
[FiraCode](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip)

### Compatibility (Optional)

For plugin compatibility with other languages, you should install the following
packages.

Python client and plugin host: [pynvim](https://github.com/neovim/pynvim)

```sh
pip install pynvim
```

Node client and plugin host:
[node-client](https://github.com/neovim/node-client)

```sh
npm i -g neovim
```

## Folder Structure

```plain
nvim                  # Neovim config directory
├─ after
│  └─ ftplugin        # Filetype specific options, keymaps
├─ lua                # Lua modules directory
│  ├─ core            # Core editor options, keymaps, autocmds
│  └─ plugins
│     ├─ cmp          # Completion config
│     ├─ dap          # Debugging config
│     ├─ lsp          # Native lsp config
│     ├─ init.lua     # Plugin definition file
│     └─ ...
├─ snippets           # Lsp compatible snippets
│  ├─ package.json    # Snippet package manifest
│  ├─ all.json        # Global snippets file
│  └─ lua.json        # Lua snippets file
└─ templates
   └─ skel/_.lua      # Default new file template
```
