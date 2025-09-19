#!/usr/bin/env zsh

# Organize media files into target directories.
tidy() {
  emulate -L zsh
  setopt local_options extended_glob

  mkdir -p "$HOME/Media"/{Pictures,Video,Audio,Documents,Misc}

  move_file() {
    local src_file=$1 dest_dir=$2
    local base_name=${src_file:t}
    local name=${base_name%.*}
    local ext=${base_name##*.}
    local dest_file=$dest_dir/$base_name
    local counter=0

    while [[ -e $dest_file ]]; do
      dest_file="$dest_dir/${name}-${counter}.${ext}"
      ((counter++))
    done

    mv "$src_file" "$dest_file"
    echo "Moved ${src_file}"
  }

  for file in *.gif(N) *.jpg(N) *.png(N); do
    [[ -e $file ]] && move_file "$file" "$HOME/Media/Pictures"
  done

  for file in *.mp3(N) *.wav(N); do
    [[ -e $file ]] && move_file "$file" "$HOME/Media/Audio"
  done

  echo "Files organized!"
}
