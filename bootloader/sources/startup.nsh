@echo -off
mode 80 25

cls
if exist .\boot\efi\bootloader.efi then
	echo "[Sartupt Script] Found bootloader on current disk"
	.\boot\efi\bootloader.efi
	goto END
endif

if exist fs0:\boot\efi\bootloader.efi then
	fs0:
	echo "[Sartupt Script] Found bootloader on fs0"
	boot\efi\bootloader.efi
	goto END
endif

if exist fs1:\boot\efi\bootloader.efi then
	fs1:
	echo "[Sartupt Script] Found bootloader on fs1"
	boot\efi\bootloader.efi
	goto END
endif

if exist fs2:\boot\efi\bootloader.efi then
	fs2:
	echo "[Sartupt Script] Found bootloader on fs2"
	boot\efi\bootloader.efi
	goto END
endif

if exist fs3:\boot\efi\bootloader.efi then
	fs3:
	echo "[Sartupt Script] Found bootloader on fs3"
	boot\efi\bootloader.efi
	goto END
endif

if exist fs4:\boot\efi\bootloader.efi then
	fs4:
	echo "[Sartupt Script] Found bootloader on fs4"
	boot\efi\bootloader.efi
	goto END
endif

if exist fs5:\boot\efi\bootloader.efi then
	fs5:
	echo "[Sartupt Script] Found bootloader on fs5"
	boot\efi\bootloader.efi
	goto END
endif

if exist fs6:\boot\efi\bootloader.efi then
	fs6:
	echo "[Sartupt Script] Found bootloader on fs6"
	boot\efi\bootloader.efi
	goto END
endif

if exist fs7:\boot\efi\bootloader.efi then
	fs7:
	echo "[Sartupt Script] Found bootloader on fs7"
	boot\efi\bootloader.efi
	goto END
endif

	echo "[Sartupt Script] Unable to find bootloader".
 
:END
