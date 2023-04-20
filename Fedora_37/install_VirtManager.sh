#!/bin/bash
# ---------------------------------------------------------------------
# Script    : install_VirtManager.sh  
# Descrição : Script para instalação do Virt-Mannager no Fedora
# Versão    : 0.01
# Site	    : https://virt-manager.org/
# Autor     : Manoel Saraiva - manoeljsaraiva@gmail.com
# Data      : 15/04/2023
# Licença   : GNU/GPL v3.0
# ---------------------------------------------------------------------
# Uso : ./install_VirtManager.sh
# ---------------------------------------------------------------------

#==========================================================================================================================
#
#                   ToDO List: 
#                    
#                  - Precisa terminar o script para alterar o arquivo de configuração libvirtd.conf, descomentar as linhas 
#                        unix_sock_group e unix_sock_rw_perms
#                   
#==========================================================================================================================




#   Instalação de programas necessários  

echo "Iniciando a instalação do Virt-Manager..."
sudo dnf install -y qemu qemu-kvm virt-top libvirt-devel libguestfs-tools guestfs-tools bridge-utils virt-manager

 
#   Iniciar e ativar o serviço

echo "Iniciando e ativando o serviço Libvirt..."
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

#   Para adicionar usuario no libvirt

echo "Adicionando o usuário ao grupo Libvirt..."
sudo usermod -a -G libvirt $(USER)



#   Precisa alterar esse arquivo
# sudo nano /etc/libvirt/libvirtd.conf
# unix_sock_group = "libvirt"
# unix_sock_rw_perms = "0770"
# sudo systemctl restart libvirtd.service
