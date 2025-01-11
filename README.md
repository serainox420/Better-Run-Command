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
# Variables:
> ### SSH Destinations
> Save your `<user>@<ip>` as variable to use with `ssh $SERVER`
```bash
export SERVER="root@127.0.0.1"
```

---
# Aliases:
