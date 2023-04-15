cd ..

git clone https://github.com/Antynea/grub-btrfs

sleep 10

cd ~/grub-btrfs

sleep 5

git switch Add-systemd-volatile

sleep 15

sed -i 's/#GRUB_BTRFS_SYSTEMD_VOLATILE=/GRUB_BTRFS_SYSTEMD_VOLATILE=/' config

sleep 15

sed -i 's/#GRUB_BTRFS_GRUB_DIRNAME=/GRUB_BTRFS_GRUB_DIRNAME=/' config

sleep 15

sed -i '/#GRUB_BTRFS_MKCONFIG=/c\GRUB_BTRFS_MKCONFIG=/sbin/grub2-mkconfig' config

sleep 15

sed -i 's/#GRUB_BTRFS_SCRIPT_CHECK=/GRUB_BTRFS_SCRIPT_CHECK=/' config

sleep 15


sudo make INITCPIO=true install

sleep 15

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sleep 15
sudo systemctl enable --now grub-btrfs.path

sleep 15

cd ..

# rm -rvf grub-btrfs


