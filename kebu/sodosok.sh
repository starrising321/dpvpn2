#!/bin/bash
#shadowsocks-libev obfs install by Adityah•NTB
source /etc/os-release
OS=$ID
ver=$VERSION_ID

#Install_Packages
echo "#############################################" | lolcat
echo "Install Paket..." | lolcat
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake -y
echo "Install Paket Selesai." | lolcat
echo "#############################################" | lolcat


#Install_Shadowsocks_libev
echo "#############################################" | lolcat
echo "Install Shadowsocks-libev..." | lolcat
apt-get install software-properties-common -y
if [[ $OS == 'ubuntu' ]]; then
apt install shadowsocks-libev -y
apt install simple-obfs -y
elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install shadowsocks-libev -y
apt -t stretch-backports install simple-obfs -y
elif [[ "$ver" = "10" ]]; then
echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list
apt update
apt -t buster-backports install shadowsocks-libev -y
apt -t buster-backports install simple-obfs -y
fi
fi
echo "Install Shadowsocks-libev Selesai."
echo "#############################################" | lolcat

#Server konfigurasi
echo "#############################################" | lolcat
echo "Konfigurasi Server." | lolcat
cat > /etc/shadowsocks-libev/config.json <<END
{   
    "server":"0.0.0.0",
    "server_port":8488,
    "password":"tes",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
}
END
echo "#############################################" | lolcat

#mulai ~shadowsocks-libev~ server
echo "#############################################" | lolcat
echo "mulai ss server" | lolcat
systemctl enable shadowsocks-libev.service
systemctl start shadowsocks-libev.service
echo "#############################################" | lolcat

#buat client config
echo "#############################################" | lolcat
echo "buat config obfs" | lolcat
cat > /etc/shadowsocks-libev.json <<END
{
    "server":"127.0.0.1",
    "server_port":8388,
    "local_port":1080,
    "password":"",
    "timeout":60,
    "method":"chacha20-ietf-poly1305",
    "mode":"tcp_and_udp",
    "fast_open":true,
    "plugin":"/usr/bin/obfs-local",
    "plugin_opts":"obfs=tls;failover=127.0.0.1:1443;fast-open"
}
END
chmod +x /etc/shadowsocks-libev.json
echo "#############################################" | lolcat

echo -e "">>"/etc/shadowsocks-libev/akun.conf"

echo "#############################################" | lolcat
echo "Menambahkan Perintah Shadowsocks-libev" | lolcat
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443:3543 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2443:3543 -j ACCEPT
iptables-save > /etc/iptables.up.rules
ip6tables-save > /etc/ip6tables.up.rules
cd /usr/bin
wget -O add-ss "https://raw.githubusercontent.com/starrising321/dpvpn2/main/kebu/add-ss.sh"
wget -O del-ss "https://raw.githubusercontent.com/starrising321/dpvpn2/main/kebu/del-ss.sh"
wget -O cek-ss "https://raw.githubusercontent.com/starrising321/dpvpn2/main/kebu/cek-ss.sh"
wget -O renew-ss "https://raw.githubusercontent.com/starrising321/dpvpn2/main/kebu/renew-ss.sh"
chmod +x add-ss
chmod +x del-ss
chmod +x cek-ss
chmod +x renew-ss
cd
rm -f /root/sodosok.sh
