#!/bin/bash

# Install dependencies
sudo apt update && sudo apt install -y stow build-essential git neovim curl

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

make
