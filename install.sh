#!/bin/bash
set -e

# 1. System deps + stow + uv (tmux is new; needed by `medusa N` for N > 1)
sudo apt update && sudo apt install -y \
  stow build-essential git neovim curl tmux
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# 2. Agent toolchain
if ! command -v ollama >/dev/null 2>&1; then
  curl -fsSL https://ollama.com/install.sh | sh
fi
if ! command -v opencode >/dev/null 2>&1; then
  curl -fsSL https://opencode.ai/install | bash
fi
if ! command -v bd >/dev/null 2>&1; then
  npm install -g @beads/bd
fi
# claude-code left out intentionally: installed on demand when you want to
# swap brains (e.g. `npm install -g @anthropic-ai/claude-code`). The
# claude-code/ stow package is inert until then.

# 3. Stow all dotfiles into $HOME (places all configs and the `medusa` script)
make

# 4. Mark the medusa entrypoint executable (git mode may not survive stow)
chmod +x "$HOME/.local/bin/medusa"

# 5. Register the 32K-context Qwen model (pulls base model on demand).
#    Idempotent: `ollama create` is a no-op if the tag already exists with
#    the same definition. Wait briefly for the service on first install.
for i in 1 2 3 4 5; do ollama list >/dev/null 2>&1 && break; sleep 1; done
ollama create qwen2.5-coder-bd:32b \
  -f "$HOME/.config/ollama/Modelfile.qwen-coder-bd"
