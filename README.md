# 🔒 FluxER

**Fluxion Easy Runner for Termux** - Automated installer for Fluxion on Android.

## Requirements

- Termux (from [F-Droid](https://f-droid.org/packages/com.termux/))
- Android 7.0+
- ~1GB free storage
- Internet connection

## Installation

```bash
pkg update && pkg upgrade -y
git clone https://github.com/0n1cOn3/FluxER.git
cd FluxER
chmod +x installer.sh
./installer.sh
```

## Usage

After installation:

```bash
proot-distro login ubuntu
cd ~/fluxion
./fluxion.sh
```

Or one-liner:
```bash
proot-distro login ubuntu -- bash -c 'cd ~/fluxion && ./fluxion.sh'
```

## Troubleshooting

**Storage permission denied:**
```bash
termux-setup-storage
```

**Ubuntu won't start:**
```bash
pkg reinstall proot-distro
```

**Reinstall everything:**
```bash
proot-distro remove ubuntu
./installer.sh
```

## Credits

- Original Script: MrBlackX/TheMasterCH
- Maintainer: [0n1cOn3](https://github.com/0n1cOn3)
- [Fluxion](https://github.com/FluxionNetwork/fluxion)

## ⚠️ Legal

**For educational and authorized testing only.** Unauthorized network access is illegal. You must have explicit permission before testing any network.

## License

GPL v3 - See [LICENSE](LICENSE)
# fluxioterWifiTermux
