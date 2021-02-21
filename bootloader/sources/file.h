// efi header
#include <efi.h>
#include <efilib.h>

extern EFI_STATUS ErrorCode;
extern EFI_HANDLE ImageHandle;
extern EFI_BOOT_SERVICES* BootServices;

EFI_FILE* LoadFile(EFI_FILE* Directory, CHAR16* Path);
