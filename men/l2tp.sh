#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
bl='\e[36;1m'
bd='\e[1m'
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/geogabut/private/main/kepo/ipvps | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Only For Premium Users"
exit 0
fi
clear
echo -e ""
figlet   L2tp + Pptp | lolcat
echo -e "\e[1;32m═══════════════════════════════════════\e[m" | lolcat
echo -e "         \e[1;31m\e[1;31m═[\e[mL2TP & PPTP Account\e[1;31m]═\e[m" 
echo -e "\e[1;32m═══════════════════════════════════════\e[m" | lolcat
echo -e "$bd 1$bl]\e[m$bd  Creating L2TP Account"
echo -e "$bd 2$bl]\e[m$bd  Create Account PPTP"
echo -e "$bd 3$bl]\e[m$bd  Deleting L2TP Account"
echo -e "$bd 4$bl]\e[m$bd  Delete PPTP Account"
echo -e "$bd 5$bl]\e[m$bd  Check User Login PPTP"
echo -e "$bd 6$bl]\e[m$bd  Renew L2TP Account"
echo -e "$bd 7$bl]\e[m$bd  Renew PPTP Account"
echo -e ""
echo -e "\e[1;32m══════════════════════════════════════════\e[m" | lolcat
echo -e " x)   MENU    \e[m"   | lolcat
echo -e "\e[1;32m══════════════════════════════════════════\e[m" | lolcat
echo -e ""
read -p "     Please Input Number  [1-7 or x] :  "  l2tp
echo -e ""
case "$l2tp" in
1)
add-l2tp
;;
2)
add-pptp
;;
3)
del-l2tp
;;
4)
del-pptp
;;
5)
cek-pptp
;;
6)
renew-l2tp
;;
7)
renew-pptp
;;
x)
menu
;;
*)
echo "Please enter an correct number"
;;
esac
