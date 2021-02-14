# UpsideOS

Welcome to my OS project !
## Build the OS
Everething should be handle via Makefile. Just run the command `make all` in the directorie were you installed the repository (It will create OS.img in a binaries dir). Then start an emulator. I advice Qemu as I only tested the worflow on Qemu. <br/>
If you use Qemu, run : <br/>
```qemu-system-x86_64 -cpu qemu64 -drive if=pflash,format=raw,unit=0,file=ovmf/OVMF_CODE-pure-efi.fd,readonly=on -drive if=pflash,format=raw,unit=1,file=ovmf/OVMF_VARS-pure-efi.fd -drive if=ide,format=raw,file=binaries/OS.img -net none```
