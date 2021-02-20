@echo -off
mode 80 25

cls
if exist .\bootloader.efi then
	.\bootloader.efi
	echo "[Sartupt Script] Found bootloader on current disk"
	goto END
endif

if exist fs0:\bootloader.efi then
	fs0:
	echo "[Sartupt Script] Found bootloader on fs0"
	bootloader.efi
	goto END
endif

if exist fs1:\bootloader.efi then
	fs1:
	echo "[Sartupt Script] Found bootloader on fs1"
	bootloader.efi
	goto END
endif

if exist fs2:\bootloader.efi then
	fs2:
	echo "[Sartupt Script] Found bootloader on fs2"
	bootloader.efi
	goto END
endif

if exist fs3:\bootloader.efi then
	fs3:
	echo "[Sartupt Script] Found bootloader on fs3"
	bootloader.efi
	goto END
endif

if exist fs4:\bootloader.efi then
	fs4:
	echo "[Sartupt Script] Found bootloader on fs4"
	bootloader.efi
	goto END
endif

if exist fs5:\bootloader.efi then
	fs5:
	echo "[Sartupt Script] Found bootloader on fs5"
	bootloader.efi
	goto END
endif

if exist fs6:\bootloader.efi then
	fs6:
	echo "[Sartupt Script] Found bootloader on fs6"
	bootloader.efi
	goto END
endif

if exist fs7:\bootloader.efi then
	fs7:
	echo "[Sartupt Script] Found bootloader on fs7"
	bootloader.efi
	goto END
endif

	echo "[Sartupt Script] Unable to find bootloader".
 
:END
