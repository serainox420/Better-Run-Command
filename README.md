<div align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=70&duration=1000&pause=2000&color=2BB279&center=true&vCenter=true&width=835&height=160&lines=Better+Run+Command" alt="Typing SVG">
  </a>
</div>

# <div align="center">Shell configs (.rc) (.bashrc / .zshrc)</a></div>

---
> ## extract
> Extract any type of archive with simple command
```bash
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xvjf "$1" ;;
            *.tar.gz) tar xvzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xvf "$1" ;;
            *.tbz2) tar xvjf "$1" ;;
            *.tgz) tar xvzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "Cannot extract '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}
```

> ---
> ## nohups
> Silent nohup (does not produce nohup.out log)
```bash
function nohups() {nohup "$@" &>/dev/null &}
```

---
> ## SSH Destinations
> Define your `<user>@<ip>` as `$SERVER` variable to use with `ssh $SERVER`
```bash
export SERVER="root@127.0.0.1"
```

---
> ## Current shell .rc
> Detect currently used shell, and define it's .rc path as `$SHRC`
```bash
case "$SHELL" in
   */bash)
       export SHRC="$HOME/.bashrc"
       ;;
   */zsh)
       export SHRC="$HOME/.zshrc"
       ;;
   */ksh)
       export SHRC="$HOME/.kshrc"
       ;;
   */fish)
       export SHRC="$HOME/.config/fish/config.fish"
       ;;
   *)
       # Fallback for other shells
       export SHRC="$HOME/.profile"
       ;;
esac
```


> ## reloadrc
> Reload shell automatically (source .$0rc)
```bash
alias reloadrc="source $SHRC"
```

> ---
> ## unsource
> Dynamically unload sorced files from current session \
> (find all vars & als & funcs from file, then unsets & unaliases them)
```bash
unsource() {
    local file="$1"
   # Check if the file exists
   if [[ ! -f "$file" ]]; then
       echo "File not found: $file"
       return 1
   fi
   # Unset all variables defined in the file
   while IFS= read -r line; do
       if [[ "$line" =~ ^([A-Za-z_][A-Za-z0-9_]*)= ]]; then
           unset "${BASH_REMATCH[1]}"
       fi
   done < <(grep -E '^[A-Za-z_][A-Za-z0-9_]*=' "$file")
   # Unset all functions defined in the file
   while IFS= read -r func_name; do
       unset -f "$func_name"
   done < <(declare -F | awk '{print $NF}' | grep -Fxf <(grep -oP '^[A-Za-z_][A-Za-z0-9_]*(?=\(\))' "$file"))
   # Unalias all aliases defined in the file
   while IFS= read -r alias_name; do
       unalias "$alias_name" 2>/dev/null
   done < <(grep -oP '^alias\s+\K[A-Za-z_][A-Za-z0-9_]*' "$file")
   # Unset all exported variables defined in the file
   while IFS= read -r export_var; do
       unset "$export_var"
   done < <(grep -oP '^export\s+\K[A-Za-z_][A-Za-z0-9_]*' "$file")
   echo "Unloaded file: $file"}
```

> ---
> ## tidy
> Move files by pattern to their target dirs (eg .mp3 to Audio folder etc)
```bash
tidy() {
   # Ensure the base directories exist
   mkdir -p "$HOME/Media"/{Pictures,Video,Audio,Documents,Misc}
   # Function to move files and avoid overwriting
   move_file() {
       local src_file="$1"
       local dest_dir="$2"
       # Extract the file name and extension
       local base_name="${src_file:t}"
       local name="${base_name%.*}"
       local ext="${base_name##*.}"
       local dest_file="$dest_dir/$base_name"
       local counter=0
       # Check for conflicts and append a number if needed
       while [[ -e "$dest_file" ]]; do
           dest_file="$dest_dir/${name}-${counter}.${ext}"
           ((counter++))
       done
       mv "$src_file" "$dest_file"
   }
   # Pictures
   for file in *.gif(N); do
       [[ -e "$file" ]] && move_file "$file" "$HOME/Media/Pictures"
       echo "Moved $file"
   done
   for file in *.jpg(N); do
       [[ -e "$file" ]] && move_file "$file" "$HOME/Media/Pictures"
       echo "Moved $file"
   done
   for file in *.png(N); do
       [[ -e "$file" ]] && move_file "$file" "$HOME/Media/Pictures"
       echo "Moved $file"
   done
   # Audio
   for file in *.mp3(N); do
       [[ -e "$file" ]] && move_file "$file" "$HOME/Media/Audio"
       echo "Moved $file"
   done
   for file in *.wav(N); do
       [[ -e "$file" ]] && move_file "$file" "$HOME/Media/Audio"
       echo "Moved $file"
   done
   # === CUSTOMIZE UP TO PREFERENCES ===
   echo "Files organized!"
}
```


---
> ## Copy & Paste
> Copy: `echo "Stuff" | copy`, `copy "Stuff"`, `copy $VAR` \
> Paste: `paste`, `<command> $(paste)`
```bash
copy() {
   # Copy from stdin (e.g., echo "text" | copy)
   if [ $# -eq 0 ]; then
       xclip -selection clipboard
   else
       # Copy directly from a string or variable
       echo -n "$*" | xclip -selection clipboard
   fi
}
paste() {
   xclip -selection clipboard -o
}
```

> ## Copy file contents
> Eg: `copyf <filename>`
```bash
alias copyf="cat $1 | xclip -selection clipboard"
```

> ## Create quick notes
```bash
note() {
    if [ $# -eq 0 ]; then
        echo "= Logging mode =\n- Type your note (press Enter for new line, end with a double quote (\") to save):\n\n"
        while IFS= read -r line; do
            if [[ "$line" == *\" ]]; then
                # Remove the trailing quote and append to the file
                echo "${line%\"}" >> ~/quick_notes.txt
                echo "Note saved!"
                break
            fi
            # Append each line to the file
            echo "$line" >> ~/quick_notes.txt
        done
    else
        # Append arguments as a single line to the file
        echo "$*" >> ~/quick_notes.txt
        echo "Note added!"
    fi
}
notes() {
    if [ -f ~/quick_notes.txt ]; then
        cat ~/quick_notes.txt
    else
        echo "No notes found."
    fi
}
```

---
# Misc:
> ## Disable EOL
> Disable the end-of-line marker [%]
```bash
export PROMPT_EOL_MARK=""
```

> ## Show Space
> Space usage for current folder
```bash
alias diskspace="du -sh * 2>/dev/null | sort -h"
```

> ## Weather
> Display weather for your location or specified city
```bash
weather() {
   if [ -z "$1" ]; then
       curl "wttr.in?format=4"
   else
       curl "wttr.in/${1// /+}?format=4"
   fi
}
```

> ## Find and open
Find any file and open with fzf
```bash
fopen() {
   local file
   file=$(find . -type f -iname "*$1*" | fzf) && xdg-open "$file"
}
```

> ## Find files by name
```bash
alias ffind="find . -type f -iname"
```

> ## Find directories by name
```bash
alias dfind="find . -type d -iname"
```

> ## Command Timer
> Time the execution of any command.
```bash
timer() {
   start=$(date +%s)
   "$@"
   end=$(date +%s)
   echo "Time elapsed: $((end - start)) seconds."
}
```

> ## Quick http python server
> Run to start py server / Optionally define port: $0 <port>
```bash
alias serve="python3 -m http.server"
```

> ## Lazy ass cd
> Use `..`, `...`, and `....` to move up by one, two or three paths
```bash
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
```

> ## mkcd
> Create a directory and immediatly cd into it
```bash
mkcd() {
    mkdir -p "$1" && cd "$1"
}
```
---
> ## Colorized Man
> Make `man` pages easier to read with syntax highlighting
```bash
# Man Syntax Highlight
export LESS_TERMCAP_mb=$'\e[1;31m'  # Red
export LESS_TERMCAP_md=$'\e[1;35m'  # Magenta
export LESS_TERMCAP_me=$'\e[0m'     # Reset
export LESS_TERMCAP_se=$'\e[0m'     # Reset
export LESS_TERMCAP_so=$'\e[1;44;33m' # Yellow on blue
export LESS_TERMCAP_ue=$'\e[0m'     # Reset
export LESS_TERMCAP_us=$'\e[1;32m'  # Green
```

> ## Grep+
> Grep highlight & count
```bash
alias grepi="grep -i --color=auto"
alias grepc="grep -c --color=auto"
```

---
> ## NET-PACK
> Set of networking aliases
```bash
# NET-PACK
# Detailed IP info
alias ipinfo="curl ipinfo.io"

# Print External IPv4 and IPv6
alias ip4ext="curl -4 ifconfig.me"
alias ip6ext="curl -6 ifconfig.me"

# Show Local IPs
alias iplocal="hostname -I | tr ' ' '\n'"

# Print Ipv6 and Ipv4
alias ip6="curl ifconfig.me"
alias ip4="hostname -I | tr ' ' '\n' | grep -oE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'"

# Show All Open Files by Network Processes
alias netfiles="sudo lsof -i"

# Print Ports & Listening Ports
alias ports="netstat -tulanp"
alias portsl="ss -tuln"

# Capture packets
alias tcpd="sudo tcpdump -i eth0"

# Test connectivity by pinging google.com / 8.8.8.8
alias pingg="ping google.com -c 4 && ping 8.8.8.8 -c 4"

# Show Gateway, Routing table & DNS Server
alias gateway="ip route | grep default | awk '{print \$3}'"
alias routes="ip route show"
alias dns="cat /etc/resolv.conf | grep nameserver | awk '{print \$2}'"

# MAC Address of Interface
alias mac="ip link show eth0 | awk '/ether/ {print \$2}'"

# VPN Status
alias vpnstatus="nmcli connection show --active | grep vpn"

# Show All Active Connections
alias activeconn="netstat -ant | grep ESTABLISHED"

# List All Listening Services
alias listensrv="sudo lsof -i -P -n | grep LISTEN"

# Display All Wireless Networks
alias showwifi="nmcli dev wifi list"

# Check SSL Certificate Expiry
alias sslcheck="echo | openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -noout -dates"
```
