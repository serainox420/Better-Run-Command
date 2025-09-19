#!/usr/bin/env zsh

# Run nohup without creating nohup.out.
nohups() {
  nohup "$@" &>/dev/null &
}
