#!/usr/bin/env zsh

# Collection of networking helpers.
alias ipinfo='curl ipinfo.io'
alias ip4ext='curl -4 ifconfig.me'
alias ip6ext='curl -6 ifconfig.me'
alias iplocal="hostname -I | tr ' ' '\n'"
alias ip6='curl ifconfig.me'
alias ip4="hostname -I | tr ' ' '\n' | grep -oE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'"
alias netfiles='sudo lsof -i'
alias ports='netstat -tulanp'
alias portsl='ss -tuln'
alias tcpd='sudo tcpdump -i eth0'
alias pingg='ping google.com -c 4 && ping 8.8.8.8 -c 4'
alias gateway="ip route | grep default | awk '{print \$3}'"
alias routes='ip route show'
alias dns="cat /etc/resolv.conf | grep nameserver | awk '{print \$2}'"
alias mac="ip link show eth0 | awk '/ether/ {print \$2}'"
alias vpnstatus='nmcli connection show --active | grep vpn'
alias activeconn='netstat -ant | grep ESTABLISHED'
alias listensrv="sudo lsof -i -P -n | grep LISTEN"
alias showwifi='nmcli dev wifi list'
alias sslcheck='echo | openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -noout -dates'
