#!/usr/bin/bash

__ROOT="$PWD"

# Check if script is running in neovim
if [ ! -z "$NVIM_LISTEN_ADDRESS" ]; then
  echo "I don't recommend running this from within neovim..."
  exit 1
fi

# Change directory to Script root
cd "$(dirname "$0")"

# Replace XDG paths for testing
export XDG_CONFIG_HOME="$__ROOT/.config"
export XDG_LOCAL_HOME="$__ROOT/.local"
export XDG_DATA_HOME="$__ROOT/.local/share"

# Ensure config folders exist
mkdir -p "$XDG_CONFIG_HOME" 1>&/dev/null
mkdir -p "$XDG_SHARE_HOME" 1>&/dev/null

# attempt to remove anythin not a link and broken links
[ ! -L "$XDG_CONFIG_HOME/nvim" ] || [ ! -e "$XDG_CONFIG_HOME/nvim" ] && {
  rm -ir "$XDG_CONFIG_HOME/nvim"
}

# Create link if nothing exists
[ ! -e "$XDG_CONFIG_HOME/nvim" ] && {
  ln -s "$PWD" "$XDG_CONFIG_HOME/nvim"
}

# Set runtime variables
export MYVIMRC="$XDG_CONFIG_HOME/nvim/init.lua"
export VIMINIT='
set rtp-=$XDG_CONFIG_HOME
set rtp-=$XDG_CONFIG_HOME/after
" set rtp^=/path/to/some-plugin
" set rtp+=/path/to/some-plugin/after
set rtp^=$XDG_CONFIG_HOME
set rtp+=$XDG_CONFIG_HOME/after
'
nvim -u "$MYVIMRC"
