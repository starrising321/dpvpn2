#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo -e  "${RED}Checking VPS${NC}"
sleep 2
IZIN=$( curl https://raw.githubusercontent.com/starrising321/ipvps/main/ipvps | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${GREEN}Permission Accepted...${NC}"
sleep 2 
else
clear
echo -e ""
echo -e "======================================="
echo -e ""
echo -e "${RED}Permission Denied...!!! ${NC}"
echo -e "IP VPS ANDA BELUM TERDAFTAR"
echo -e "Contact WA https//wa.me/+6281285970456"
echo -e "For Registration IP VPS"
echo -e ""
echo -e "======================================="
echo -e ""
rm setup.sh
exit 0
fi
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
IP=$(wget -qO- ifconfig.co);
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "NAME : SSH, WebSocket, Openvpn"
echo -e "===============================" | lolcat
echo -e "Username      : $Login "
echo -e "Password      : $Pass"
echo -e "Expired On    : $exp"
echo -e "===============================" | lolcat
echo -e "ISP           : $ISP"
echo -e "Host          : $IP"
echo -e "Domain        : $domain"
echo -e "OpenSSH       : 22"
echo -e "Dropbear      : 109, 143"
echo -e "SSL/TLS       :$ssl"
echo -e "SSLH          : 333"
echo -e "WS SSL        : 443"
echo -e "WS Non SSL    : 2095"
echo -e "WS Ovpn       : 2082"
echo -e "Port Squid    :$sqd"
echo -e "Badvpn Udpgw  : 7100-7300"
echo -e "===============================" | lolcat
echo -e "OpenVPN TCP   : $ovpn http://$IP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN UDP   : $ovpn2 http://$IP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN SSL   : 442  http://$IP:81/client-tcp-ssl.ovpn"
echo -e "===============================" | lolcat
echo -e "[PAYLOAD SSH WS]" | lolcat
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "===============================" | lolcat
echo -e " Script Installer By : DP VPN" | lolcat
echo -e "===============================" | lolcat
