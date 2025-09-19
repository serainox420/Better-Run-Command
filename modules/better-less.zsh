#!/usr/bin/env zsh

# Better less wrappers with consistent color output.
les() {
  command less -r +G -X -- "$@"
}

lez() {
  command ls --color=always -1 "$@" | les
}

lezz() {
  lsf "$@" | les
}
