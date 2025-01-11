<div align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=70&duration=1000&pause=2000&color=2BB279&center=true&vCenter=true&width=835&height=160&lines=Better+Run+Command" alt="Typing SVG">
  </a>
</div>

## <div align="center">Shell (rc) configs (.bashrc / .zshrc)</a></div>

---
> ### nohups
> Silent nohup (does not produce nohup.out log)
```bash
function nohups() {
    nohup "$@" &>/dev/null &
}
```
> ---
> ### SSH Destinations
> Define your `<user>@<ip>` as `$SERVER` variable to use with `ssh $SERVER`
```bash
export SERVER="root@127.0.0.1"
```
> ---
> ### Current shell .rc
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
> ### reloadrc
> Reload shell automatically (source .$0rc)
```bash
alias reloadrc="source $SHRC"
```
> ---
> ### unsource
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
    echo "Unloaded file: $file"
}
```
> ---
> ### tidy
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
# Misc:
> ### Disable EOL
> Disable the end-of-line marker [%]
```bash
export PROMPT_EOL_MARK=""
```
> ### Lazy ass cd
> Use `..`, `...`, and `....` to move up by one, two or three paths
```bash
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
```
> ### mkcd
> Create a directory and immediatly cd into it
```bash
mkcd() {
    mkdir -p "$1" && cd "$1"
}
```
---
