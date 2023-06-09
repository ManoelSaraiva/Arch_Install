#!/bin/bash
# ---------------------------------------------------------------------
# Script    : install_Snapper.sh  
# Descrição : Script para instalação e configuração do snapper no Fedora 37
# Versão    : 0.01
# Site	    : https://sysguides.com/install-fedora-37-with-snapper-and-grub-btrfs/
# Autor     : Manoel Saraiva - manoeljsaraiva@gmail.com
# Data      : 15/04/2023
# Licença   : GNU/GPL v3.0
# ---------------------------------------------------------------------
# Uso : ./install_Snapper.sh
# ---------------------------------------------------------------------


# ---------------------------------------------------------------------
#   Variaveis
# ---------------------------------------------------------------------
partition="nvme0n1p4"

# ---------------------------------------------------------------------



echo "Mudando o label"
sudo btrfs filesystem label / FEDORA



# Renomeia Var/log
sudo mv -v /var/log /var/log-old

sleep 2

echo "Criando o subvolume /var/log"
sudo btrfs subvolume create /var/log
sleep 2

# Copia os arquivos
sudo cp -arv /var/log-old/. /var/log/
sleep 2

# ?
sudo restorecon -RFv /var/log
sleep 2

# Deleta o antigo var/log
sudo rm -rvf /var/log-old


# Adicionar a linha /var/log no fstab

uuid_number="$(sudo blkid -s UUID -o value /dev/$partition)"

# * UUID=ff003a16-2819-493a-b4a5-4a8dec85ea7d /var/log  btrfs subvol=var/log,compress=zstd:1 0 0
# echo "UUID="$uuid_number"    /var/log    btrfs   subvol=var/log,compress=zstd:1 0 0" | sudo tee -a /etc/fstab


# Reload fstab 
sudo systemctl daemon-reload
sudo mount -va


echo lsblk -p


sudo btrfs subvolume list /

# Instalando programas necessários.
#
# snapper
# python-dnf-plugin-snapper
# make

sudo dnf install -y snapper python3-dnf-plugin-snapper make


sudo snapper -c root create-config /
sudo snapper -c home create-config /home



sudo snapper list-configs

# **********************************************************
sudo snapper -c root set-config ALLOW_USERS=$USER SYNC_ACL=yes
sudo snapper -c home set-config ALLOW_USERS=$USER SYNC_ACL=yes


# Muda as permissões do grupo
sudo chown -R :$USER /.snapshots
sudo chown -R :$USER /home/.snapshots


#	Caso o home esteja em um HD diferente

#   Adicionar essas duas linhas ao fstab
#
#   UUID=ff003a16-2819-493a-b4a5-4a8dec85ea7d /                btrfs defaults 0 0
#   UUID=0799-62F5                            /boot/efi        vfat  umask=0077,shortname=winnt 0 2
#   UUID=ff003a16-2819-493a-b4a5-4a8dec85ea7d /home            btrfs subvol=home,compress=zstd:1 0 0
#   UUID=ff003a16-2819-493a-b4a5-4a8dec85ea7d /var/log         btrfs subvol=var/log,compress=zstd:1 0 0
# *  UUID=ff003a16-2819-493a-b4a5-4a8dec85ea7d /.snapshots      btrfs subvol=.snapshots,compress=zstd:1 0 0
# *  UUID=ff003a16-2819-493a-b4a5-4a8dec85ea7d /home/.snapshots btrfs subvol=home/.snapshots,compress=zstd:1 0 0

# Reload o fstab
sudo systemctl daemon-reload
sudo mount -va

# Para mostrar como esta indo as configuraçoes
# lsblk -p /dev/vda

# Enable snapshot booting by appending the SUSE_BTRFS_SNAPSHOT_BOOTING="true" option to the /etc/default/grub file.
echo 'SUSE_BTRFS_SNAPSHOT_BOOTING="true"' | sudo tee -a /etc/default/grub


# Because snapshot booting is now enabled, you must make changes to the /boot/efi/EFI/fedora/grub.cfg file as well.
sudo sed -i '1i set btrfs_relative_path="yes"' /boot/efi/EFI/fedora/grub.cfg

# Update Grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Disabilita o Grub menu auto-hide
sudo grub2-editenv - unset menu_auto_hide

#==========================================================================================================================
#
#                                      Install and Configure Grub-Btrfs
#
#==========================================================================================================================

cd ..

git clone https://github.com/Antynea/grub-btrfs

sleep 10

# Entra no diretorio ~/grub-btrfs
cd ~/grub-btrfs

sleep 5


echo "Diretorio onde estou: "
echo pwd

git switch Add-systemd-volatile

sleep 5

echo "Primeiro SED"
sed -i 's/#GRUB_BTRFS_SYSTEMD_VOLATILE=/GRUB_BTRFS_SYSTEMD_VOLATILE=/' config

sleep 5

echo "Segundo SED"
sed -i 's/#GRUB_BTRFS_GRUB_DIRNAME=/GRUB_BTRFS_GRUB_DIRNAME=/' config

sleep 5

echo "Terceiro SED"
sed -i '/#GRUB_BTRFS_MKCONFIG=/c\GRUB_BTRFS_MKCONFIG=/sbin/grub2-mkconfig' config

sleep 5

echo "Quarto SED"
sed -i 's/#GRUB_BTRFS_SCRIPT_CHECK=/GRUB_BTRFS_SCRIPT_CHECK=/' config

sleep 5

sudo make INITCPIO=true install

sleep 5

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sleep 5
sudo systemctl enable --now grub-btrfs.path

sleep 5

# Saindo da pasta ~/grub-btrfs
cd ..

# Deletando o ~/grub-btrfs
# rm -rvf grub-btrfs


