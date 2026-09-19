#!/usr/bin/env bash
set -euo pipefail

# Ubuntu 24.04 ships python3.12 without ensurepip, which `python3 -m venv` needs.
if ! dpkg -s python3.12-venv >/dev/null 2>&1; then
  sudo apt-get update -qq
  sudo apt-get install -y -qq python3.12-venv
fi

# grip renders README.md exactly as GitHub does (the profile preview "app").
GRIP_VENV="$HOME/.venvs/grip"
if [ ! -x "$GRIP_VENV/bin/grip" ]; then
  python3 -m venv "$GRIP_VENV"
  "$GRIP_VENV/bin/pip" install --upgrade pip
fi
"$GRIP_VENV/bin/pip" install --upgrade grip

# markdownlint-cli lints the profile Markdown.
npm config set prefix "$HOME/.npm-global"
npm install -g markdownlint-cli
