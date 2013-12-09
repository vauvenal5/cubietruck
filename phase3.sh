mount -t ext4 /dev/nandb /mnt/rootfs

cp /mnt/rootfs/etc/modules /etc/modules
cp -r /mnt/rootfs/lib/modules/* /lib/modules/