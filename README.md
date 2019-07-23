### BUILD
```
user@host:~/gs-openwrt$ ./build-me.sh
```
Resulting firmware images are located at ./bin/targets/ar71xx/generic/*.  

The openwrt-ar71xx-generic-oolitebox-squashfs-sysupgrade.bin file is used for updating a device that already has firmware installed on it.

### CONNECT TO DEVICE
Connect your host to the LAN port on the device using an ethernet cable.  Use DHCP - you should get a 192.168.1.x address.
```
user@host:~/gs-openwrt$ ssh root@192.168.1.1
```

### UPGRADE FIRMWARE
```
user@host:~/gs-openwrt$ scp ./bin/targets/ar71xx/generic/*-sysupgrade.bin root@192.168.1.1:/tmp/
root@openwrt:~# ssh root@192.168.1.1
root@openwrt:~# sysupgrade /tmp/*-sysupgrade.bin
```

### Building UBoot
Install these packages if you are running on a 64bit OS:
`sudo apt install libc6-i386 lib32stdc++6 zlib1g:i386`

To build:

```
# cd /uboot
# make clean
# make all
```

