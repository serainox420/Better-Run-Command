#!/usr/bin/env zsh

# Global arrays to track multiple stray processes
typeset -ga STRAY_PIDS
typeset -ga STRAY_CMDS

# Start process in background (detached) and remember it
stray() {
    if (( $# == 0 )); then
        print -u2 "stray: need a command"
        return 1
    fi

    nohup "$@" >/dev/null 2>&1 &
    local pid=$!

    STRAY_PIDS+=$pid
    STRAY_CMDS+="$*"

    local idx=$#STRAY_PIDS
    printf "Started [%d] PID=%d: %s\n" "$idx" "$pid" "$*"
}

# List all tracked stray processes
strays() {
    if (( $#STRAY_PIDS == 0 )); then
        echo "No stray processes tracked."
        return 0
    fi

    local i
    for i in {1..$#STRAY_PIDS}; do
        printf "[%d] PID=%-7d %s\n" "$i" "$STRAY_PIDS[i]" "$STRAY_CMDS[i]"
    done
}

# Kill stray process(es)
#   slay        -> kill last started stray
#   slay N      -> kill stray with index N from `strays`
#   slay all    -> kill all tracked strays
slay() {
    local idx pid

    # Kill all tracked PIDs
    if [[ "$1" == "all" ]]; then
        if (( $#STRAY_PIDS == 0 )); then
            echo "No stray processes to kill."
            return 0
        fi
        echo "Killing all: ${STRAY_PIDS[*]}"
        kill -9 "${STRAY_PIDS[@]}" 2>/dev/null
        STRAY_PIDS=()
        STRAY_CMDS=()
        return
    fi

    # No arg -> last one
    if [[ -z "$1" ]]; then
        idx=$#STRAY_PIDS
    # Numeric arg -> treat as index
    elif [[ "$1" == <-> ]]; then
        idx=$1
    # Non-numeric -> treat as raw PID
    else
        pid=$1
    fi

    # Resolve PID from index if needed
    if [[ -z "$pid" ]]; then
        if (( idx < 1 || idx > $#STRAY_PIDS )); then
            print -u2 "slay: invalid index: $idx"
            return 1
        fi
        pid=${STRAY_PIDS[idx]}
    fi

    if ! kill -9 -- "$pid" 2>/dev/null; then
        print -u2 "slay: failed to kill PID $pid"
        return 1
    fi

    echo "Killed PID=$pid"

    # If we killed by index, drop it from the tracking arrays
    if [[ -n "$idx" ]]; then
        STRAY_PIDS[$idx]=()
        STRAY_CMDS[$idx]=()
    fi
}
