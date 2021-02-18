#include <efi.h>
#include <efilib.h>

EFI_STATUS ErrorCode;
EFI_HANDLE ImageHandle;
EFI_BOOT_SERVICES* BootServices;

EFI_FILE* LoadFile(EFI_FILE* Directory, CHAR16* Path)
{
	EFI_STATUS Status;
	EFI_FILE* File;

	EFI_LOADED_IMAGE_PROTOCOL* LoadedImage = NULL;
	{
		Status = uefi_call_wrapper(BootServices->OpenProtocol, 6, ImageHandle, &gEfiLoadedImageProtocolGuid, (void **)&LoadedImage, ImageHandle, NULL, EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);
		if (Status != EFI_SUCCESS)
		{
			ErrorCode = Status;
			return NULL;
		}
	}

	EFI_SIMPLE_FILE_SYSTEM_PROTOCOL* FileSystem;
	{
		Status = uefi_call_wrapper(BootServices->OpenProtocol, 6, LoadedImage->DeviceHandle, &gEfiSimpleFileSystemProtocolGuid, (void **)&FileSystem, ImageHandle, NULL, EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);
		if (Status != EFI_SUCCESS)
		{
			ErrorCode = Status;
			return NULL;
		}
	}

	if (Directory == NULL)
	{
		Status = uefi_call_wrapper(FileSystem->OpenVolume, 2, FileSystem, &Directory);
		if (Status != EFI_SUCCESS)
		{
			ErrorCode = Status;
			return NULL;
		}
	}

	Status = uefi_call_wrapper(Directory->Open, 5, Directory, &File, Path, EFI_FILE_MODE_READ, 0);
	if (Status != EFI_SUCCESS)
	{
		ErrorCode = Status;
		return NULL;
	}

	return File;
}

EFI_STATUS efi_main(EFI_HANDLE Image, EFI_SYSTEM_TABLE* SystemTable)
{
	ImageHandle = Image;
	BootServices = SystemTable->BootServices;

	InitializeLib(Image, SystemTable);
	Print(L"[Bootloader] Ver:0.2\n\r");

	if (LoadFile(NULL, L"kernel.elf") == NULL)
	{
		Print(L"[Bootloader] Could not open the file, returned with error code %d\n\r", ErrorCode);
		return ErrorCode;
	}
	Print(L"[Bootloader] Kernel Loaded successfully\n\r");

	return EFI_SUCCESS;
}
