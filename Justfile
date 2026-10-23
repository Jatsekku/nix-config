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

# Deploy host configuration remotely via nixos-anywhere
# Usage: just deploy HOST IP
deploy host ip:
    @read -p "Deploy [{{host}}] to [{{ip}}] via nixos-anywhere? [y/N] " confirm && [[ "$confirm" =~ ^[yY]$ ]] || { echo "Aborted."; exit 0; }
    nix run nixpkgs#nixos-anywhere -- \
    --flake .#{{host}} \
    --generate-hardware-config nixos-facter ./modules/hosts/{{host}}/_facter.json \
    root@{{ip}}

serve-pixie:
    #!/usr/bin/env bash
    #TODO: Move it to separate script
    PORT="80"
    STATUS_PORT="80"

    echo "Inserting rules into NixOS firewall for Pixiecore..."
    sudo iptables -w -I nixos-fw -p udp -m multiport --dports 67,69,4011 -j ACCEPT
    sudo iptables -w -I nixos-fw -p tcp -m tcp --dport "$PORT" -j ACCEPT
    if [ "$PORT" != "$STATUS_PORT" ]; then
        sudo iptables -w -I nixos-fw -p tcp -m tcp --dport "$STATUS_PORT" -j ACCEPT
    fi
    sudo iptables -w -I nixos-fw -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    # Ensure rules are cleanly deleted from the nixos-fw chain on exit (even on Ctrl+C)
    cleanup() {
        echo ""
        echo "Cleaning up NixOS firewall rules..."
        sudo iptables -w -D nixos-fw -p udp -m multiport --dports 67,69,4011 -j ACCEPT || true
        sudo iptables -w -D nixos-fw -p tcp -m tcp --dport "$PORT" -j ACCEPT || true
        if [ "$PORT" != "$STATUS_PORT" ]; then
            sudo iptables -w -D nixos-fw -p tcp -m tcp --dport "$STATUS_PORT" -j ACCEPT || true
        fi
        sudo iptables -w -D nixos-fw -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT || true
    }
    trap cleanup EXIT

    echo "Building netboot artifacts for selaginella..."
    KERNEL=$(nix build .#nixosConfigurations.selaginella.config.system.build.kernel --no-link --print-out-paths)
    RAMDISK=$(nix build .#nixosConfigurations.selaginella.config.system.build.netbootRamdisk --no-link --print-out-paths)
    TOPLEVEL=$(nix build .#nixosConfigurations.selaginella.config.system.build.toplevel --no-link --print-out-paths)

    echo "Starting Pixiecore..."
    sudo nix run nixpkgs#pixiecore -- boot \
        "$KERNEL/bzImage" \
        "$RAMDISK/initrd" \
        --cmdline "init=${TOPLEVEL}/init loglevel=4" \
        --dhcp-no-bind \
        --debug
