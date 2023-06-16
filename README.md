### Disable sleep on laptop lid close

/etc/systemd/logind.conf:

```conf
HandleLidSwitch=ignore
```

### Disable wifi powersave

/etc/NetworkManager/conf.d/wifi-powersave.conf:

```conf
[connection]
wifi.powersave = 2
```

### Install NixOS

```bash
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- mkpart primary 512MiB 100%

mkfs.fat -F32 -n BOOT /dev/sda1
mkfs.ext4 -L nixos /dev/sda2

nix-shell -p git nixFlakes

git clone https://github.com/dongsu8142/dotfiles

nixos-install --root /mnt --impure --flake .#home-linux
```
