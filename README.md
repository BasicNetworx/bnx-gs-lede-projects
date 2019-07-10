### BUILD
```
$ echo 'CONFIG_TARGET_ar71xx=y
CONFIG_TARGET_ar71xx_generic=y
CONFIG_TARGET_ar71xx_generic_DEVICE_oolitebox=y' > .config
```
```
$ make defconfig
```
```
$ make -j<n>
```
Resulting firmware images are located at ./bin/targets/ar71xx/generic/*.  
The *-sysupgrade.bin file is used for updating a device that already has firmware installed on it.


### CONNECT TO DEVICE
Connect your host to the LAN port on the device using an ethernet cable.  Use DHCP - you should get a 192.168.1.x address.
```
$ ssh root@192.168.1.1
```

### UPGRADE FIRMWARE
```
[host]$ scp ./bin/targets/ar71xx/generic/*-sysupgrade.bin root@192.168.1.1/tmp/
[host]$ ssh root@192.168.1.1
[target]$ sysupgrade /tmp/*-sysupgrade.bin
```
