#!/usr/bin/env zsh

# Clipboard helpers powered by xclip.
copy() {
  if [[ $# -eq 0 ]]; then
    xclip -selection clipboard
  else
    printf "%s" "$*" | xclip -selection clipboard
  fi
}

paste() {
  xclip -selection clipboard -o
}
