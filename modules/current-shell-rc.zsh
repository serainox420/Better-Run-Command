#!/usr/bin/env zsh

# Detect the current shell and expose its rc file path.
case "$SHELL" in
  */bash)
    export SHRC="$HOME/.bashrc"
    ;;
  */zsh)
    export SHRC="$HOME/.zshrc"
    ;;
  */ksh)
    export SHRC="$HOME/.kshrc"
    ;;
  */fish)
    export SHRC="$HOME/.config/fish/config.fish"
    ;;
  *)
    export SHRC="$HOME/.profile"
    ;;
esac
