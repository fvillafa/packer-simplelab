Download ubuntu-26.04-live-server-amd64.iso in the same directory as this lab.

iso_url can be a remote location, but my internet connection is not that stable. If it's a remote url and checksum matches, Packer will download it only once and reuse it.

Build with `packer build .`

Provisioned user is ubuntu/ubuntu, suit to taste.

Try artifacts with:

Legacy BIOS: 

`qemu-system-x86_64 -enable-kvm -m 1G -cpu host -smp 1 -drive file=ubuntu-kvm-packer,format=qcow2`

UEFI:
```
cp /usr/share/OVMF/OVMF_VARS_4M.fd <your working dir>

qemu-system-x86_64 -enable-kvm -m 1G -cpu host -smp 1 -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.fd -drive if=pflash,format=raw,file=./OVMF_VARS_4M.fd -drive file=ubuntu-kvm-packer,format=qcow2
```
TODO:

- Use keys instead of user/pass.
- Try VirtualBox builder.
- Try multiple build targets.
