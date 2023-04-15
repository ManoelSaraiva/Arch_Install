


sed -i 's/#GRUB_BTRFS_SYSTEMD_VOLATILE=/GRUB_BTRFS_SYSTEMD_VOLATILE=/' config

sed -i 's/#GRUB_BTRFS_GRUB_DIRNAME=/GRUB_BTRFS_GRUB_DIRNAME=/' config

sed -i '/#GRUB_BTRFS_MKCONFIG=/c\GRUB_BTRFS_MKCONFIG=/sbin/grub2-mkconfig' config

sed -i 's/#GRUB_BTRFS_SCRIPT_CHECK=/GRUB_BTRFS_SCRIPT_CHECK=/' config

sudo make INITCPIO=true install

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo systemctl enable --now grub-btrfs.path

cd ..

rm -rvf grub-btrfs
