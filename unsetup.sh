#!/bin/bash

loopback=$(cat loopback.info)

umount OS/
losetup -d $loopback
