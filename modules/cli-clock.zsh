#!/usr/bin/env zsh

# Render a large ASCII clock in the terminal.
clock() {
  local cmd="figlet"
  local -a args=()
  local fmt="%H:%M"

  while [[ $# -gt 0 ]]; do
    case $1 in
      -t|--toilet)
        cmd="toilet"
        shift
        ;;
      -s|--seconds)
        fmt="%H:%M:%S"
        shift
        ;;
      *)
        args+=("$1")
        shift
        ;;
    esac
  done

  while true; do
    clear
    tput civis
    local out="$(date +"$fmt" | $cmd "${args[@]}")"
    local rows=$(echo "$out" | wc -l)
    local cols=$(echo "$out" | head -n1 | wc -c)
    local term_rows=$(tput lines)
    local term_cols=$(tput cols)
    local pad_top=$(( (term_rows - rows) / 2 ))
    local pad_left=$(( (term_cols - cols) / 2 ))

    for ((i=0; i<pad_top; i++)); do
      echo
    done

    echo "$out" | while IFS= read -r line; do
      printf "%*s%s\n" $pad_left "" "$line"
    done

    sleep 1
  done

  tput cnorm
}
