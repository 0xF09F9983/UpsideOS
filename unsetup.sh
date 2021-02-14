#!/bin/bash

loopback=$(cat loopback.info)
sudo rm loopback.info 

sudo umount OS/
sudo losetup -d $loopback
