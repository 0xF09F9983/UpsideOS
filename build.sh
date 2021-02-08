if ! mountpoint -q "OS"; then
	echo "/dev/UpsideOS not mounted, did you run setup.sh first ?"
fi

if [ ! -d "OS/efi/boot/" ]; then
	mkdir -p OS/efi/boot/
fi

cp bootloader/binaries/boot.efi OS/efi/boot/main.efi
cp bootloader/sources/startup.nsh OS/
