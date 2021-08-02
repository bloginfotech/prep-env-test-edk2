#!/bin/bash

sudo snap install codium

sudo apt install qemu-kvm ovmf

mkdir "~/bin"
mkdir -p "~/wrk/test"

cat > ~/bin/efitest.sh <<EOF
#!/bin/bash

qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -drive file=fat:rw:~/wrk/test -boot c -nic none

EOF
