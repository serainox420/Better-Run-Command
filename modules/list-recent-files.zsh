#!/usr/bin/env zsh

# List files sorted by modification time with trimmed names.
lsf() {
  command ls --color=always --hyperlink=never -1 -p -t "$@" \
  | tac \
  | awk '
    BEGIN{
      ESC=sprintf("%c",27); esc_re=ESC "\\[[0-9;]*[A-Za-z]"; reset_re=ESC "\\[[0-9;]*m"; max=25
    }
    {
      orig=$0
      plain=orig; gsub(esc_re,"",plain)
      if (plain ~ /\/$/) next
      col=""; rest=orig
      while (match(rest, "^" esc_re)) {
        col=col substr(rest,RSTART,RLENGTH); rest=substr(rest,RLENGTH+1)
      }
      reset=""; t=orig
      while (match(t, reset_re)) {
        reset=substr(t,RSTART,RLENGTH); t=substr(t,RSTART+RLENGTH)
      }
      n=length(plain); dotpos=0
      for (i=2;i<=n-1;i++) if (substr(plain,i,1)==".") dotpos=i
      if (dotpos>1) { base=substr(plain,1,dotpos-1); ext=substr(plain,dotpos+1) } else { base=plain; ext="" }
      base_max=max; if (ext!="") base_max=max-1-length(ext); if (base_max<1) base_max=1
      vbase=substr(base,1,base_max)
      out=vbase ((ext!="") ? "." ext : "")
      printf "%s%s%s\n", col, out, reset
    }'
}
