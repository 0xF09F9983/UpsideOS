#include <efi.h>
#include <efilib.h>
 
EFI_STATUS efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
{
	InitializeLib(ImageHandle, SystemTable);
	Print(L"===== Kernel (Ver. Hello World) =====\r\n");
	Print(L"  Hello, world!\r\n");
	return EFI_SUCCESS;
}
