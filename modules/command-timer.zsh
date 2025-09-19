#!/usr/bin/env zsh

# Measure how long a command takes to execute.
timer() {
  local start end
  start=$(date +%s)
  "$@"
  end=$(date +%s)
  echo "Time elapsed: $((end - start)) seconds."
}
