#!/bin/bash

cd bootloader/ && ./reset.sh && cd ../
cd kernel/ && ./reset.sh && cd ../


if [ -d binaries/ ]; then
	rm -drf binaries/
fi

if [ -d OS/ ]; then
	rm -drf OS/
fi

if [ -f loopback.info ]; then
	rm -drf loopback.info
fi
