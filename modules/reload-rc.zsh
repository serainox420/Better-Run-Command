#!/usr/bin/env zsh

# Quickly reload the current shell configuration.
reloadrc() {
  if [[ -z ${SHRC:-} ]]; then
    echo "SHRC is not set"
    return 1
  fi
  source "$SHRC"
}
