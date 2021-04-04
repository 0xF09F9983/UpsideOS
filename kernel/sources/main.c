#include <efi.h>
#include <efilib.h>

#include <stdint.h>

void kmain(EFI_GRAPHICS_OUTPUT_PROTOCOL* gop)
{
	unsigned int y = 50;
	unsigned int bbp = 4;

	for (unsigned int x = 0; x < gop->Mode->Info->HorizontalResolution / 2 * bbp; x++)
	{
		*(unsigned int*)(x + (y * gop->Mode->Info->PixelsPerScanLine * bbp) + gop->Mode->FrameBufferBase) = 0xffffffff;
	}
	while (1) {}

	return;
}
