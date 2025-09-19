#!/usr/bin/env zsh

# Unload variables, aliases, and functions defined in a file.
unsource() {
  emulate -L zsh
  setopt local_options extended_glob

  local file=$1
  if [[ -z $file ]]; then
    echo "Usage: unsource <file>"
    return 1
  fi

  if [[ ! -f $file ]]; then
    echo "File not found: $file"
    return 1
  fi

  local name

  while IFS= read -r name; do
    [[ -n $name ]] && unset "$name"
  done < <(sed -n 's/^\([A-Za-z_][A-Za-z0-9_]*\)=.*/\1/p' "$file")

  while IFS= read -r name; do
    [[ -n $name ]] && unset -f "$name"
  done < <(sed -n 's/^\([A-Za-z_][A-Za-z0-9_]*\)()[[:space:]]*{.*/\1/p' "$file")

  while IFS= read -r name; do
    [[ -n $name ]] && unalias "$name" 2>/dev/null
  done < <(sed -n 's/^alias[[:space:]]\+\([A-Za-z_][A-Za-z0-9_]*\).*/\1/p' "$file")

  while IFS= read -r name; do
    [[ -n $name ]] && unset "$name"
  done < <(sed -n 's/^export[[:space:]]\+\([A-Za-z_][A-Za-z0-9_]*\).*/\1/p' "$file")

  echo "Unloaded file: $file"
}
