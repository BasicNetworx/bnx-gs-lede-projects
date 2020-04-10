### PREREQ

These instructions assume the build host is running Ubuntu 16 or 18.  

Run the following command to install required packages:
```
$ sudo apt-get install -y time git-core subversion build-essential gcc-multilib libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python
```
Clone this repo:
```
user@host:~/gs-openwrt$ git clone git@github.com:BasicNetworx/openwrt-gainstrong.git
```

### BUILD FIRMWARE
```
user@host:~/gs-openwrt$ ./bnx-dev-build.sh
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

