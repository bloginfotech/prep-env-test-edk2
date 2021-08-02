#!/bin/bash


sudo apt install qemu-kvm ovmf snapd
sudo snap install codium



mkdir ~/bin
mkdir ~/wrk
mkdir ~/wrk/test



cat > ~/bin/efitest.sh <<EOF
#!/bin/bash

qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -drive file=fat:rw:~/wrk/test -boot c -nic none -usb -device usb-mouse

EOF
chmod +x ~/bin/efitest.sh

cat > ~/bin/prepare_edk2_project_files.sh <<EOF
#!/bin/bash

if [ \$# -lt 3 ]; then
echo "Usage: prepare_edk2_project_files.sh <nom du projet> <repertoire du projet complet> <repertoire du framework edk2>";
exit 0;
fi



PROJECTNAME=\$1
PROJECTDIR=\$2
EDK2WORKSPACE=\$3
mkdir \$PROJECTDIR
cd \$PROJECTDIR
mkdir .vscode
cd .vscode
cat > tasks.json <<EOF2
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "efitest",
            "command": "~/bin/efitest.sh",
            "args": [
                ""
            ],
            "type": "shell",
            "problemMatcher": []
        },
	  {  
            "label": "preparetest",
            "command": "\$PROJECTDIR/bin/copy_efi_file_to_test.sh",
            "args": [
                ""
            ],
            "type": "shell",
            "problemMatcher": []
	},
	{
	   "label": "build",
            "command": "\$PROJECTDIR/bin/build.sh",
            "args": [
                ""
            ],
            "type": "shell",
            "problemMatcher": []
	}
    ]
}
EOF2

cd ..
mkdir \$PROJECTDIR/bin

cat > \$PROJECTDIR/bin/copy_efi_file_to_test.sh <<EOF3
#!/bin/bash
cp \$EDK2WORKSPACE/Build/\$PROJECTNAME/DEBUG*/X64/*.efi ~/wrk/test/
EOF3
chmod +x \$PROJECTDIR/bin/copy_efi_file_to_test.sh

cat > \$PROJECTDIR/bin/build.sh <<EOF4
#!/bin/bash
cd \$EDK2WORKSPACE
. edksetup.sh
build -a X64 -t GCC5 -p \$PROJECTDIR/\$PROJECTNAME.dsc

EOF4
chmod +x \$PROJECTDIR/bin/build.sh


cd  \$PROJECTDIR
codium -n . 
EOF
chmod +x  ~/bin/prepare_edk2_project_files.sh





