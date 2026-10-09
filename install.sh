#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/prentece/git-agent-commit.git"
INSTALL_DIR="${HOME}/.git-agent-commit"
BIN_DIR="${HOME}/.local/bin"

if [ -d ".git" ] && [ -d "bin" ]; then
  SRC_DIR="$(pwd)"
else
  if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing installation at $INSTALL_DIR..."
    git -C "$INSTALL_DIR" pull --quiet
  else
    echo "Cloning repository to $INSTALL_DIR..."
    git clone --quiet "$REPO_URL" "$INSTALL_DIR"
  fi
  SRC_DIR="$INSTALL_DIR"
fi

mkdir -p "$BIN_DIR"

for binary in "$SRC_DIR"/bin/*; do
  [ -f "$binary" ] || continue
  chmod +x "$binary"
  ln -sf "$binary" "$BIN_DIR/$(basename "$binary")"
done

echo "Binaries installed to $BIN_DIR"

if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
  ZSHRC="$HOME/.zshrc"
  SOURCE_LINE="source \"$SRC_DIR/git-agent-commit.plugin.zsh\""
  if ! grep -q "git-agent-commit.plugin.zsh" "$ZSHRC" 2>/dev/null; then
    echo "" >> "$ZSHRC"
    echo "# Git Agent Commit Plugin" >> "$ZSHRC"
    echo "$SOURCE_LINE" >> "$ZSHRC"
    echo "Added plugin source to $ZSHRC"
  fi
fi

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo ""
  echo "Notice: $BIN_DIR is not in your PATH."
  echo "Add it by running: export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo ""
echo "Installation complete! Restart your shell or run: source ~/.zshrc"
