#!/usr/bin/env zsh

# Create a directory and enter it.
mkcd() {
  mkdir -p "$1" && cd "$1"
}
