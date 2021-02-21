#include "file.h"

EFI_LOADED_IMAGE_PROTOCOL* LoadedImage = NULL;
EFI_SIMPLE_FILE_SYSTEM_PROTOCOL* FileSystem = NULL;

EFI_FILE* LoadFile(EFI_FILE* Directory, CHAR16* Path)
{
	EFI_FILE* File;

	if (LoadedImage == NULL)
	{
		ErrorCode = uefi_call_wrapper(BootServices->OpenProtocol, 6, ImageHandle, &gEfiLoadedImageProtocolGuid, (void **)&LoadedImage, ImageHandle, NULL, EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);
		if (ErrorCode != EFI_SUCCESS)
			return NULL;
	}

	if (FileSystem == NULL)
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

