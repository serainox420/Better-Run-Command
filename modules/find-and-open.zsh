#!/usr/bin/env zsh

# Fuzzy-find a file and open it.
fopen() {
  local term=${1:-}
  local file
  file=$(find . -type f -iname "*${term}*" | fzf) || return 1
  xdg-open "$file"
}
