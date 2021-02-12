@echo -off
mode 80 25

cls
echo "===== Sartupt Script (Ver:0.1.1) ====="

if exist .\bootloader.efi then
	.\bootloader.efi
	echo "  Found bootloader on current disk"
	echo " "
	goto END
endif

if exist fs0:\bootloader.efi then
	fs0:
	echo "  Found bootloader on fs0"
	echo " "
	bootloader.efi
	goto END
endif

if exist fs1:\bootloader.efi then
	fs1:
	echo "  Found bootloader on fs1"
	echo " "
	bootloader.efi
	goto END
endif

if exist fs2:\bootloader.efi then
	fs2:
	echo "  Found bootloader on fs2"
	echo " "
	bootloader.efi
	goto END
endif

if exist fs3:\bootloader.efi then
	fs3:
	echo "  Found bootloader on fs3"
	echo " "
	bootloader.efi
	goto END
endif

if exist fs4:\bootloader.efi then
	fs4:
	echo "  Found bootloader on fs4"
	echo " "
	bootloader.efi
	goto END
endif

if exist fs5:\bootloader.efi then
	fs5:
	echo "  Found bootloader on fs5"
	echo " "
	bootloader.efi
	goto END
endif

if exist fs6:\bootloader.efi then
	fs6:
	echo "  Found bootloader on fs6"
	echo " "
	bootloader.efi
	goto END
endif

if exist fs7:\bootloader.efi then
	fs7:
	echo "  Found bootloader on fs7"
	echo " "
	bootloader.efi
	goto END
endif

	echo "  Unable to find bootloader".
	echo " "
 
:END
