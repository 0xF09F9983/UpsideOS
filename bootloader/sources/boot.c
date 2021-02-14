#include <efi.h>
#include <efilib.h>
 
EFI_STATUS efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
{
	InitializeLib(ImageHandle, SystemTable);
	Print(L"[Bootloader] Ver:Hello World\n");
	Print(L"[Bootloader] Hello, world!\n");

	EFI_STATUS status;

	// Flush out the input buffer
	status = uefi_call_wrapper(SystemTable->ConIn->Reset, 2, SystemTable->ConIn, FALSE);
	if (EFI_ERROR(status))
		return status;

	{
		EFI_INPUT_KEY key;
		while((status = uefi_call_wrapper(SystemTable->ConIn->ReadKeyStroke, 2, SystemTable->ConIn, &key)) == EFI_NOT_READY);
	}

	return EFI_SUCCESS;
}
