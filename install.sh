#!/bin/bash

# Install dependencies
sudo apt update && sudo apt install -y stow build-essential git neovim curl jq tmux

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Pre-create target dirs so stow links files into them instead of folding the
# whole directory into the repo (which would put settings.json, caches, etc. there)
mkdir -p "$HOME/.claude" "$HOME/.codex" "$HOME/.config"

make

# Configure Claude hooks (settings.json can't be stowed, so merge in)
./claude/setup-claude-hooks.sh
