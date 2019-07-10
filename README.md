### BUILD
```
user@host:~/gs-openwrt$ echo 'CONFIG_TARGET_ar71xx=y
CONFIG_TARGET_ar71xx_generic=y
CONFIG_TARGET_ar71xx_generic_DEVICE_oolitebox=y' > .config
user@host:~/gs-openwrt$ make defconfig
user@host:~/gs-openwrt$ make -j<n>
```
Resulting firmware images are located at ./bin/targets/ar71xx/generic/*.  
The *-sysupgrade.bin file is used for updating a device that already has firmware installed on it.


### CONNECT TO DEVICE
Connect your host to the LAN port on the device using an ethernet cable.  Use DHCP - you should get a 192.168.1.x address.
```
user@host:~/gs-openwrt$ ssh root@192.168.1.1
```

### UPGRADE FIRMWARE
```
user@host:~/gs-openwrt$ scp ./bin/targets/ar71xx/generic/*-sysupgrade.bin root@192.168.1.1/tmp/
root@openwrt:~# ssh root@192.168.1.1
root@openwrt:~# sysupgrade /tmp/*-sysupgrade.bin
```
