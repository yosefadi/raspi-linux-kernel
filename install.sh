#!/bin/bash

# This script is used to install the kernel and modules to the SD card
export RASPI_BOOT_PART=/dev/sda1
export RASPI_ROOT_PART=/dev/sda2

mkdir -p /mnt/raspi/boot
mkdir -p /mnt/raspi/root

mount -t vfat $RASPI_BOOT_PART /mnt/raspi/boot
mount -t ext4 $RASPI_ROOT_PART /mnt/raspi/root

# Copy the kernel and modules
cp -Rf boot/* /mnt/raspi/boot/
cp -Rf lib/* /mnt/raspi/root/lib/

# Unmount
umount /mnt/raspi/boot
umount /mnt/raspi/root
