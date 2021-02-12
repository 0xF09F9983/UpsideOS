if ! mountpoint -q "OS/"; then
	echo "Loopback device not mounted, did you run setup.sh first ?"
fi

make -C bootloader/
cp bootloader/binaries/* OS/
