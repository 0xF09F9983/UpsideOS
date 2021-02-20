#include "file.h"

extern EFI_STATUS ErrorCode;
extern EFI_HANDLE ImageHandle;
extern EFI_BOOT_SERVICES* BootServices;

EFI_FILE* LoadFile(EFI_FILE* Directory, CHAR16* Path)
{
	EFI_FILE* File;

	EFI_LOADED_IMAGE_PROTOCOL* LoadedImage;
	{
		ErrorCode = uefi_call_wrapper(BootServices->OpenProtocol, 6, ImageHandle, &gEfiLoadedImageProtocolGuid, (void **)&LoadedImage, ImageHandle, NULL, EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);
		if (ErrorCode != EFI_SUCCESS)
			return NULL;
	}

	EFI_SIMPLE_FILE_SYSTEM_PROTOCOL* FileSystem;
	{
		ErrorCode = uefi_call_wrapper(BootServices->OpenProtocol, 6, LoadedImage->DeviceHandle, &gEfiSimpleFileSystemProtocolGuid, (void **)&FileSystem, ImageHandle, NULL, EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);
		if (ErrorCode != EFI_SUCCESS)
			return NULL;
	}

	if (Directory == NULL)
	{
		ErrorCode = uefi_call_wrapper(FileSystem->OpenVolume, 2, FileSystem, &Directory);
		if (ErrorCode != EFI_SUCCESS)
			return NULL;
	}

	ErrorCode = uefi_call_wrapper(Directory->Open, 5, Directory, &File, Path, EFI_FILE_MODE_READ, 0);
	if (ErrorCode != EFI_SUCCESS)
		return NULL;

	return File;
}

