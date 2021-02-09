@echo -off
mode 80 25

cls
echo "[Sartupt Script] Ver:0.1.1"

if exist .\efi\boot\main.efi then
	.\efi\boot\main.efi
	echo "[Sartup Script] Found bootloader on current disk"
	goto END
endif

if exist fs0:\efi\boot\main.efi then
	fs0:
	echo "[Startup Scipt] Found bootloader on fs0"
	efi\boot\main.efi
	goto END
endif

if exist fs1:\efi\boot\main.efi then
	fs1:
	echo "[Startup Script] Found bootloader on fs1"
	efi\boot\main.efi
	goto END
endif

if exist fs2:\efi\boot\main.efi then
	fs2:
	echo "[Startup Script] Found bootloader on fs2"
	efi\boot\main.efi
	goto END
endif

if exist fs3:\efi\boot\main.efi then
	fs3:
	echo "[Startup Script] Found bootloader on fs3"
	efi\boot\main.efi
	goto END
endif

if exist fs4:\efi\boot\main.efi then
	fs4:
	echo "[Startup Script] Found bootloader on fs4"
	efi\boot\main.efi
	goto END
endif

if exist fs5:\efi\boot\main.efi then
	fs5:
	echo "[Startup Script] Found bootloader on fs5"
	efi\boot\main.efi
	goto END
endif

if exist fs6:\efi\boot\main.efi then
	fs6:
	echo "[Startup Script] Found bootloader on fs6"
	efi\boot\main.efi
	goto END
endif

if exist fs7:\efi\boot\main.efi then
	fs7:
	echo "[Startup Script] Found bootloader on fs7"
	efi\boot\main.efi
	goto END
endif

	echo "[Startup Script] Unable to find bootloader".
 
:END
