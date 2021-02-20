// efi header
#include <efi.h>
#include <efilib.h>

// elf header
#include <elf.h>

// freestanding lib
// #include <stdbool.h> // bool type
#include <stddef.h> // size_t and NULL (NULL already provided by gnu-efi)
#include <stdint.h> // intx_t & uintx_t

#define DEBUG_TRACE
#define DEBUG_ERROR
#include "debug.h"
#include "file.h"

EFI_STATUS ErrorCode;
EFI_HANDLE ImageHandle;
EFI_BOOT_SERVICES* BootServices;



int memcmp(const void* aptr, const void* bptr, size_t n)
{
	const uint8_t *a = aptr, *b = bptr;
	for (size_t i = 0; i < n; i++)
	{
		if (a[i] < b[i]) return -1;
		if (a[i] > b[i]) return 1;
	}
	return 0;
}

EFI_STATUS efi_main(EFI_HANDLE Image, EFI_SYSTEM_TABLE* SystemTable)
{
	ImageHandle = Image;
	BootServices = SystemTable->BootServices;

	InitializeLib(Image, SystemTable);

	EFI_FILE* kernelfile = LoadFile(NULL, L"kernel.elf");
	if (kernelfile == NULL)
	{
		DEBUG_MSG_ERROR(L"Could not load the kernelfile, LoadFile(NULL, L\"kernel.elf\") returned with error code %d\n\r", ErrorCode)
		return ErrorCode;
	}

	DEBUG_MSG_TRACE(L"kernel.elf opened")

	Elf64_Ehdr header;
	{
		UINTN size = sizeof(header);
		ErrorCode = uefi_call_wrapper(kernelfile->Read, 3, kernelfile, &size, &header);
		if (ErrorCode != EFI_SUCCESS)
		{
			DEBUG_MSG_ERROR(L"Unable to read the kernel.elf header, kernelfile->Read(kernelfile, &size, &header) returned with error code %d\n\r", ErrorCode)
			return ErrorCode;
		}
	}

	if (
			memcmp(&header.e_ident[EI_MAG0], ELFMAG, SELFMAG) != 0 ||
			header.e_ident[EI_CLASS] != ELFCLASS64 ||
			header.e_ident[EI_DATA] != ELFDATA2LSB ||
			header.e_type != ET_EXEC ||
			header.e_machine != EM_X86_64 ||
			header.e_version != EV_CURRENT
	   )
	{
		DEBUG_MSG_ERROR(L"The kernel executable file is ill-formated")
		return EFI_ABORTED;
	}
	DEBUG_MSG_TRACE(L"kernelfile executable sucessfully verified")

	Elf64_Phdr* phdrs;
	{
		uefi_call_wrapper(kernelfile->SetPosition, 2, kernelfile, header.e_phoff);
		UINTN size = header.e_phnum * header.e_phentsize;
		uefi_call_wrapper(BootServices->AllocatePool, 3, EfiLoaderData, size, (void **)&phdrs);
		uefi_call_wrapper(kernelfile->Read, 3, kernelfile, &size, phdrs);
	}

	for (
			Elf64_Phdr* phdr = phdrs;
			(char*)phdr < (char*)phdrs + header.e_phnum * header.e_phentsize;
			phdr = (Elf64_Phdr *)((char*)phdr + header.e_phentsize)
	    )
	{
		if (phdr->p_type == PT_LOAD)
		{
			int pages = (phdr->p_memsz + 0x1000 - 1) / 0x1000;
			Elf64_Addr segment = phdr->p_paddr;
			uefi_call_wrapper(BootServices->AllocatePages, 4, AllocateAddress, EfiLoaderData, pages, &segment);
			uefi_call_wrapper(kernelfile->SetPosition, 2, kernelfile, phdr->p_offset);

			UINTN size = phdr->p_filesz;
			uefi_call_wrapper(kernelfile->Read, 3, kernelfile, &size, (void *)segment);
		}
	}
	DEBUG_MSG_TRACE(L"kernelfile Loaded successfully")
	
	int (*kernel)() = ((__attribute__((sysv_abi)) int (*)() ) header.e_entry);

	Print(L"[Bootloader] kernelfile returned %d after call\n\r", kernel());
	
	return EFI_SUCCESS;
}
