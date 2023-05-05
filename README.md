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
