#!/data/data/com.termux/files/usr/bin/bash
# FluxER - Fluxion Easy Runner for Termux
# Created by MrBlackX/TheMasterCH | Maintainer: 0n1cOn3

set -e

# Colors
RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
YELLOW='\e[1;33m'
NC='\e[0m'

DISTRO="ubuntu"

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║            FluxER Installer            ║${NC}"
echo -e "${BLUE}║     Fluxion Easy Runner for Termux     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check if running in Termux
if [[ ! -d "/data/data/com.termux" ]]; then
    echo -e "${RED}[!] This script must be run in Termux${NC}"
    exit 1
fi

# Request storage permission
if [[ ! -d "$HOME/storage" ]]; then
    echo -e "${YELLOW}[*] Requesting storage permission...${NC}"
    termux-setup-storage
    sleep 3
fi

echo -e "${GREEN}[*] Updating packages...${NC}"
pkg update -y
pkg upgrade -y

echo -e "${GREEN}[*] Installing dependencies...${NC}"
pkg install -y proot-distro git wget curl

# Install Ubuntu if not present
if ! proot-distro list | grep -q "$DISTRO"; then
    echo -e "${GREEN}[*] Installing Ubuntu (this takes a few minutes)...${NC}"
    proot-distro install $DISTRO
else
    echo -e "${YELLOW}[*] Ubuntu already installed${NC}"
fi

echo -e "${GREEN}[*] Setting up Fluxion inside Ubuntu...${NC}"

# Create setup script
cat > /tmp/setup_fluxion.sh << 'EOF'
#!/bin/bash
set -e

apt-get update -y
apt-get upgrade -y

apt-get install -y \
    git wget curl unzip \
    net-tools wireless-tools \
    aircrack-ng hostapd dnsmasq \
    lighttpd php-cgi iptables \
    isc-dhcp-server macchanger

# Optional tools (don't fail if unavailable)
apt-get install -y reaver bully pixiewps hashcat ettercap-text-only 2>/dev/null || true

cd /root
if [[ -d "fluxion" ]]; then
    cd fluxion && git pull
else
    git clone https://github.com/FluxionNetwork/fluxion.git
    cd fluxion
fi
chmod +x fluxion.sh

echo "Fluxion setup complete!"
EOF

chmod +x /tmp/setup_fluxion.sh
proot-distro login $DISTRO --shared-tmp -- bash /tmp/setup_fluxion.sh
rm -f /tmp/setup_fluxion.sh

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       Installation Complete! ✓         ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}To run Fluxion:${NC}"
echo -e "  ${YELLOW}proot-distro login ubuntu${NC}"
echo -e "  ${YELLOW}cd ~/fluxion && ./fluxion.sh${NC}"
echo ""
echo -e "${BLUE}Or one-liner:${NC}"
echo -e "  ${YELLOW}proot-distro login ubuntu -- bash -c 'cd ~/fluxion && ./fluxion.sh'${NC}"
echo ""
