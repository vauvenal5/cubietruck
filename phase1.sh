#the following three commands have to be only executed the first time after flashing lubuntu
#mkdir /mnt/boot
#mkdir /mnt/rootfs
#apt-get install debootstrap

mount /dev/mmcblk0p2 /mnt/rootfs
rm -rf /mnt/rootfs/*
debootstrap --verbose --arch armhf --variant=minbase --foreign testing /mnt/rootfs http://ftp.debian.org/debian
cp phase2.sh /mnt/rootfs/
chroot /mnt/rootfs