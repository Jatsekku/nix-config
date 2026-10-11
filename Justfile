default:
    @just --list

# Burn artemisia configuration to a target disk
# Usage: just burn-artemisia [DISK_PATH]
burn-artemisia disk="/dev/disk/by-id/usb-MS_YSUSP20-256GSR_AA000000000000000479-0:0":
    @test -e "{{disk}}" || { echo "Error: Disk [{{disk}}' not found."; exit 0; }
    @read -p "Wipe [{{disk}}] and install [artemisia]? [y/N] " confirm && [[ "$confirm" =~ ^[yY]$ ]] || { echo "Aborted."; exit 0; }
    sudo disko-install \
        --mode format \
        --flake .#artemisia \
        --disk main "{{disk}}"

