#!/bin/bash
echo 'CONFIG_TARGET_ar71xx=y CONFIG_TARGET_ar71xx_generic=y CONFIG_TARGET_ar71xx_generic_DEVICE_oolitebox=y' > .config
make defconfig
make -n -j2 | tee buildlog.log
