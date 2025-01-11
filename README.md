# Better-Run-Command
> ### Shell run command configs (.bashrc / .zshrc)
---
# Functions:
> ### nohups
> Silent nohup (does not produce nohup.out log)
```bash
function nohups() {
    nohup "$@" &>/dev/null &
}
```
> ### reloadrc
> Reload shell automatically (source .Xrc)
```bash
function reloadrc() {
  # Detect the running shell name, e.g. "zsh" or "bash"
  local current_shell
  current_shell=$(ps -p $$ -o comm=)
  case "$current_shell" in
    zsh)
      echo "Reloading ~/.zshrc..."
      source ~/.zshrc
      ;;
    bash)
      echo "Reloading ~/.bashrc..."
      . ~/.bashrc
      ;;
    *)
      echo "Unknown shell: $current_shell"
      ;;
  esac
}
```


---
# $ Variables:
> ### SSH Destinations
> Define your `<user>@<ip>` as `$SERVER` variable to use with `ssh $SERVER`
```bash
export SERVER="root@127.0.0.1"
```

> ### Current shell .rc
> Detect currently used shell, and define it's .rc path as `$SHRC`
```bash
set_shrc() {
  if [ -n "$ZSH_VERSION" ]; then
    export SHRC="$HOME/.zshrc"
  elif [ -n "$BASH_VERSION" ]; then
    export SHRC="$HOME/.bashrc"
  else
    # Fallback for other shells (customize as needed)
    export SHRC="$HOME/.bashrc"
  fi
}
set_shrc
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
