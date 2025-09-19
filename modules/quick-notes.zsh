#!/usr/bin/env zsh

# Simple note taking helpers.
note() {
  if [[ $# -eq 0 ]]; then
    echo "= Logging mode =\n- Type your note (press Enter for new line, end with a double quote (\") to save):\n"
    while IFS= read -r line; do
      if [[ $line == *\" ]]; then
        echo "${line%\"}" >> ~/quick_notes.txt
        echo "Note saved!"
        break
      fi
      echo "$line" >> ~/quick_notes.txt
    done
  else
    echo "$*" >> ~/quick_notes.txt
    echo "Note added!"
  fi
}

notes() {
  if [[ -f ~/quick_notes.txt ]]; then
    cat ~/quick_notes.txt
  else
    echo "No notes found."
  fi
}
