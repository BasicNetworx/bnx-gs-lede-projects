#!/bin/bash
echo -e 'CONFIG_TARGET_ar71xx=y\nCONFIG_TARGET_ar71xx_generic=y\nCONFIG_TARGET_ar71xx_generic_DEVICE_oolitebox=y\n' > .config
make defconfig
make -n -j2 | tee buildlog.log
