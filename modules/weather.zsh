#!/usr/bin/env zsh

# Display the weather for the current location or a provided city.
weather() {
  if [[ -z $1 ]]; then
    curl "wttr.in?format=4"
  else
    local query=${1// /+}
    curl "wttr.in/${query}?format=4"
  fi
}
