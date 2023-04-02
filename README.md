### Packages

```bash
yay -S hyprland-bin kitty waybar-hyprland-git swaybg rofi     \
brightnessctl pamixer otf-sora adobe-source-code-pro-fonts    \
ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font    \
ttf-fantasque-nerd noto-fonts noto-fonts-emoji ttf-comfortaa  \
ttf-jetbrains-mono-nerd ttf-icomoon-feather ttf-iosevka-nerd  \
ttf-firacode-nerd polkit-gnome dunst papirus-icon-theme bluez \
bluez-utils starship
```

### disable wifi powersave

/etc/NetworkManager/conf.d/wifi-powersave.conf:

```conf
[connection]
wifi.powersave = 2
```
