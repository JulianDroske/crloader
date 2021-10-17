# crloader
Boot up ChromiumOS directly from a disk image.

The ChromiumOS LiveCD

---

# Attention: to use initrd (crloader.gz), you MUST load a generic kernel instead of the one from ChromiumOS.
To use a ChromiumOS kernel to boot up, you may need to unpack them into an ext4 partition, then load /init as init.

---

# Getting Started
You need to install grub2 or other bootloaders first.

Configuration example for GRUB2 (grub.cfg)
```
menuentry 'CloudReady with CrLoader' {
	set root=(hd0,1)
	linux /vmlinuz init=/init security=selinux selinux=1 enforcing=0 ROOTDEV= IMGPATH= OSNUM= OEMNUM= MODEV=
	initrd /initrd.gz /crloader.gz
}
```
for syslinux
```
label crloader
menu label ChromiumOS with CrLoader
kernel vmlinuz
append initrd=initrd.gz,crloader.gz security=selinux selinux=1 enforcing=0 ROOTDEV= IMGPATH= OSNUM= OEMNUM= MODEV=
```
Which:
```
vmlinuz:				is the kernel
init:					the INIT. At present it's a symbolic link to /xinitx32. The bug in fdisk x86_64 is still there.
security...enforcing:	/sbin/init of ChromiumOS requires selinux to be enabled.
ROOTDEV:				The device/partition containing ChromiumOS Image, currently only supports absolute path (e.g. /dev/sda1).
IMGPATH:				Path to the Image under $ROOTDEV.
OSNUM:					The partition number of ROOT-A inside ChromiumOS Image.
OEMNUM:					The partition number of OEM inside ChromiumOS Image.
MODEV:					The device/partition containing kernel modules.
initrd.gz:				Original initrd image corresponding with vmlinuz (For loading drivers such as amdgpu).
```
Which:
```
ROOTDEV, IMGPATH, OSNUM must be set.
To use modules on the disk, you need to put the folder 'lib' containing folder 'modules' at / of the $MODEV
Multi-loading /initrd.gz /crloader.gz does not support QEMU direct-booting. You need to create a drive containig modules(as the last line says) to boot.
```

---

To build an initramfs image, run './make'.
This will generate /tmp/crloader.gz.
Copy it to somewhere you want, then load.

---

This project does not contain modules. Include your modules from kernel first.
Tested: CloudReady v83.4.4 with Linux kernel 5.12.12-generic

