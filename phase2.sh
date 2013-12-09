#Inside the chroot now:
/debootstrap/debootstrap --second-stage

cat <<END > /etc/apt/sources.list
deb http://ftp.debian.org/debian/ testing main contrib non-free
deb-src http://ftp.debian.org/debian/ testing main contrib non-free
deb http://ftp.debian.org/debian/ testing-updates main contrib non-free
deb-src http://ftp.debian.org/debian/ testing-updates main contrib non-free
deb http://security.debian.org/ testing/updates main contrib non-free
deb-src http://security.debian.org/ testing/updates main contrib non-free
END

apt-get update

export LANG=C
apt-get install apt-utils dialog locales
dpkg-reconfigure locales
# Choose en_US.UTF-8 for both prompts, or whatever you want.
export LANG=en_US.UTF-8

apt-get install dhcp3-client udev netbase ifupdown iproute openssh-server iputils-ping wget net-tools ntpdate ntp vim nano less tzdata console-tools module-init-tools mc

cat <<END > /etc/network/interfaces
auto lo eth0
allow-hotplug eth0
iface lo inet loopback
iface eth0 inet static
	address 192.168.1.200
	netmask 255.255.255.0
	gateway 192.168.1.1
END
echo aurora > /etc/hostname

cat <<END > /etc/fstab
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/mmcblk0p2  /                ext4    noatime,errors=remount-ro 0 1
/dev/mmcblk0p1  /boot            ext2    noatime,noauto,errors=remount-ro 0 1
END

apt-get install openssh-server
passwd

echo "T0:2345:respawn:/sbin/getty -L ttyS0 115200 vt100" >> /etc/inittab

mkdir /mnt/boot
mkdir /mnt/rootfs
mkdir /lib/modules

/etc/init.d/ntp stop