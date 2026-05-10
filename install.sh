#!/bin/bash
set -euo pipefail

GGUF_REPO="${GGUF_REPO:-Qwen/Qwen2.5-Coder-32B-Instruct-GGUF}"
GGUF_FILE="${GGUF_FILE:-qwen2.5-coder-32b-instruct-q5_k_m.gguf}"
MODEL_DIR="${MODEL_DIR:-$HOME/.local/share/models}"

# 1. System deps
sudo apt update && sudo apt install -y \
  stow build-essential git neovim curl tmux
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# 2. Agent toolchain

# llama.cpp (prebuilt binary with CUDA)
if ! command -v llama-server >/dev/null 2>&1; then
  LLAMA_URL=$(curl -s https://api.github.com/repos/ggerganov/llama.cpp/releases/latest \
    | grep -o '"browser_download_url": "[^"]*ubuntu-x64-cuda[^"]*\.tar\.gz"' \
    | head -1 | cut -d'"' -f4)
  [[ -n "$LLAMA_URL" ]] || { echo "could not find llama.cpp CUDA release asset"; exit 1; }
  echo "downloading llama.cpp from $LLAMA_URL ..."
  curl -L "$LLAMA_URL" -o /tmp/llama-cpp.tar.gz
  LLAMA_DIR="$HOME/.local/lib/llama-cpp"
  mkdir -p "$LLAMA_DIR" "$HOME/.local/bin"
  tar -xzf /tmp/llama-cpp.tar.gz -C "$LLAMA_DIR"
  rm /tmp/llama-cpp.tar.gz
  LLAMA_BIN=$(find "$LLAMA_DIR" -name 'llama-server' -type f | head -1)
  BIN_DIR=$(dirname "$LLAMA_BIN")
  cat > "$HOME/.local/bin/llama-server" <<WRAPPER
#!/bin/bash
exec env LD_LIBRARY_PATH="$BIN_DIR:\${LD_LIBRARY_PATH:-}" "$LLAMA_BIN" "\$@"
WRAPPER
  chmod +x "$HOME/.local/bin/llama-server"
fi

# GGUF model (~22 GB download)
if [[ ! -f "$MODEL_DIR/$GGUF_FILE" ]]; then
  mkdir -p "$MODEL_DIR"
  uvx --from huggingface-hub huggingface-cli download \
    "$GGUF_REPO" "$GGUF_FILE" \
    --local-dir "$MODEL_DIR" \
    --local-dir-use-symlinks False
fi

if ! command -v opencode >/dev/null 2>&1; then
  curl -fsSL https://opencode.ai/install | bash
fi
if ! command -v bd >/dev/null 2>&1; then
  npm install -g @beads/bd
fi

# 3. Stow all dotfiles into $HOME
make

# 4. Mark medusa executable (git mode may not survive stow)
chmod +x "$HOME/.local/bin/medusa"
