#!/bin/bash

nome_pc = "pinoquio"
nome_usuario = "msaraiva"
layout_teclado = "KEYMAP=br-abnt2"

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc


sed -i '388s/.//' /etc/locale.gen
locale-gen

echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf

# Layout do teclado
echo $layout_teclado >> /etc/vconsole.conf

# Adicionar um nome ao computador
echo $nome_pc >> /etc/hostname

# Configuração do arquivo hosts
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $nome_pc.localdomain $nome_pc" >> /etc/hosts

# Senha do usuario root
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# Instalar o grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB 


# Gerar o grub.cfg
grub-mkconfig -o /boot/grub/grub.cfg

# Ativar serviços
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid


# Criar o usuario e adicionar a senha
useradd -m $nome_usuario
echo $nome_usuario:password | chpasswd

# Adicionar o usuario ao grupo libvirt
usermod -aG libvirt $nome_usuario


echo "$nome_usuario ALL=(ALL) ALL" >> /etc/sudoers.d/$nome_usuario


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




