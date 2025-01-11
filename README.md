# Better-Run-Command
> ### Shell run command configs (.bashrc / .zshrc)

---
> ### nohups
> Silent nohup (does not produce nohup.out log)
```bash
function nohups() {
    nohup "$@" &>/dev/null &
}
```
---
> ### SSH Destinations
> Define your `<user>@<ip>` as `$SERVER` variable to use with `ssh $SERVER`
```bash
export SERVER="root@127.0.0.1"
```
---
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
---
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
---
# Misc:
> ### Disable EOL
> Disable the end-of-line marker [%]
```bash
export PROMPT_EOL_MARK=""
```

---
# Aliases:
