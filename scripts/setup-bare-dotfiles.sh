#!/usr/bin/env bash
set -euo pipefail

# setup-bare-dotfiles.sh
# Create or clone a bare dotfiles repo at $HOME/.dotfiles.git and check out files into $HOME
# Usage: setup-bare-dotfiles.sh [local-clone-path|remote-url]

ARG=${1:-}
GIT_DIR="$HOME/.dotfiles.git"
WORK_TREE="$HOME"

if [ -d "$GIT_DIR" ]; then
  echo "Bare repo already exists at $GIT_DIR"
else
  if [ -n "$ARG" ]; then
    if [ -d "$ARG" ] && [ -d "$ARG/.git" ]; then
      echo "Creating bare repo from local clone at $ARG"
      git clone --bare "$ARG" "$GIT_DIR"
    else
      echo "Cloning remote $ARG as bare repo"
      git clone --bare "$ARG" "$GIT_DIR"
    fi
  else
    echo "Initializing empty bare repo at $GIT_DIR"
    git init --bare "$GIT_DIR"
  fi
fi

# Write alias helper file
cat > "$HOME/.dotfilesrc" <<'EOF'
alias dotfiles='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
EOF

echo "Wrote ~/.dotfilesrc (source this from your shell profile)."

echo "Checking out dotfiles to $WORK_TREE"
set +e
OUT=$(git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" checkout 2>&1)
RC=$?
set -e

if [ $RC -ne 0 ]; then
  echo "Checkout reported conflicts. Backing up current files to ~/.dotfiles-backup/"
  mkdir -p "$HOME/.dotfiles-backup"
  echo "$OUT" | sed -n '/^\s*\S/ p' | sed 's/^\s*//g' | while read -r f; do
    if [ -e "$HOME/$f" ] || [ -L "$HOME/$f" ]; then
      mkdir -p "$(dirname "$HOME/.dotfiles-backup/$f")"
      mv -v "$HOME/$f" "$HOME/.dotfiles-backup/$f" || true
    fi
  done
  git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" checkout
fi

git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" config --local status.showUntrackedFiles no

echo "Setup finished. To use: add 'source ~/.dotfilesrc' to your shell profile (e.g. ~/.zshrc)."
echo "If you want paths like ~/.codex/AGENTS.md tracked, ensure the repo stores the file at .codex/AGENTS.md"
