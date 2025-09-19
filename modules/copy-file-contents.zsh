#!/usr/bin/env zsh

# Copy the contents of a file to the clipboard.
copyf() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: copyf <file>"
    return 1
  fi

  local file=$1
  if [[ ! -f $file ]]; then
    echo "File not found: $file"
    return 1
  fi

  cat -- "$file" | xclip -selection clipboard
}
