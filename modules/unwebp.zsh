#!/usr/bin/env zsh

# Convert WebP images in the current directory to PNG.
unwebp() {
  emulate -L zsh
  setopt local_options null_glob

  local f out
  for f in *.webp; do
    out=${f%.webp}.png
    if ffmpeg -loglevel error -y -i "$f" "$out"; then
      rm -f "$f"
      echo "[*] $f → $out"
    fi
  done
}
