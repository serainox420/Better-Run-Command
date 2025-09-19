#!/usr/bin/env zsh

# Preview available ASCII art fonts.
ascii_fonts() {
  emulate -L zsh
  setopt local_options null_glob

  local tool="figlet" ex="flf" text="example" speed=0
  local -a dirs
  dirs=(/usr/share/figlet /usr/share/figlet/fonts ~/.local/share/figlet ~/.figlet)

  while [[ $# -gt 0 ]]; do
    case $1 in
      -t|--toilet)
        tool="toilet"
        ex="tlf"
        dirs=(/usr/share/figlet ~/.local/share/figlet ~/.figlet)
        shift
        ;;
      -e|--example)
        if [[ -z ${2:-} ]]; then
          echo "Missing text for -e/--example"
          return 1
        fi
        text=$2
        shift 2
        ;;
      -s|--speed)
        if [[ -z ${2:-} ]]; then
          echo "Missing value for -s/--speed"
          return 1
        fi
        speed=$2
        shift 2
        ;;
      --)
        shift
        break
        ;;
      *)
        break
        ;;
    esac
  done

  local -a cmd
  if [[ $tool == figlet ]]; then
    cmd=(figlet -f)
  else
    cmd=(toilet -f)
  fi

  local found=0 out font
  local dir f
  for dir in "$dirs[@]"; do
    [[ -d $dir ]] || continue
    for f in "$dir"/*.${ex}(N); do
      [[ -f $f ]] || continue
      font=${${f##*/}%.$ex}

      out=$("${cmd[@]}" "$font" -- "$text" 2>/dev/null) || continue

      echo "---------------------------"
      if (( speed > 0 )); then
        while IFS= read -r line; do
          print -r -- "$line"
          sleep "$speed"
        done <<< "$out"
      else
        print -r -- "$out"
      fi
      echo "$font"
      echo
      found=1
    done
  done

  (( found )) || echo "No fonts found. Blame Bill Gates."
}
