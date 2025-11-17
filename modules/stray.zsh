#!/usr/bin/env zsh

# Start process in background (detached & export pid as $PID)
stray() {
    nohup "$@" >/dev/null 2>&1 &
    PID=$!
    export PID
    printf "Started PID: %s\n" "$PID"
}
