#!/data/data/com.termux/files/usr/bin/bash
# FluxER - Fluxion Easy Runner for Termux
# Created by MrBlackX/TheMasterCH | Maintainer: 0n1cOn3

set -e

RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
YELLOW='\e[1;33m'
NC='\e[0m'

DISTRO="ubuntu"
REPO="https://github.com/davad00/fluxioterWifiTermux.git"

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║            FluxER Installer            ║${NC}"
echo -e "${BLUE}║     Fluxion Easy Runner for Termux     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check Termux
if [[ ! -d "/data/data/com.termux" ]]; then
    echo -e "${RED}[!] Run this in Termux${NC}"
    exit 1
fi

# Storage permission
[[ ! -d "$HOME/storage" ]] && termux-setup-storage && sleep 3

echo -e "${GREEN}[*] Updating packages...${NC}"
pkg update -y && pkg upgrade -y

echo -e "${GREEN}[*] Installing dependencies...${NC}"
pkg install -y proot-distro git

# Install Ubuntu if needed
if ! proot-distro list | grep -q "$DISTRO"; then
    echo -e "${GREEN}[*] Installing Ubuntu...${NC}"
    proot-distro install $DISTRO
else
    echo -e "${YELLOW}[*] Ubuntu already installed${NC}"
fi

echo -e "${GREEN}[*] Setting up Fluxion inside Ubuntu...${NC}"

proot-distro login $DISTRO -- bash -c "
set -e
apt-get update -y
apt-get install -y git wget curl unzip net-tools iw aircrack-ng hostapd dnsmasq lighttpd php-cgi iptables macchanger
apt-get install -y isc-dhcp-server reaver bully pixiewps hashcat ettercap-text-only 2>/dev/null || true

cd /root
rm -rf fluxion fluxioterWifiTermux
git clone $REPO
mv fluxioterWifiTermux fluxion 2>/dev/null || true
cd fluxion
[[ -f fluxion.sh ]] && chmod +x fluxion.sh
echo 'Fluxion ready!'
"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       Installation Complete! ✓         ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}To run Fluxion:${NC}"
echo -e "  ${YELLOW}proot-distro login ubuntu${NC}"
echo -e "  ${YELLOW}cd ~/fluxion && ./fluxion.sh${NC}"
echo ""
