#!/bin/bash
# ---------------------------------------------------------------------
# Script    : install_VsCode.sh  
# Descrição : Script para instalação do VsCode no Fedora
# Versão    : 0.01
# Site	    : https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
# Autor     : Manoel Saraiva - manoeljsaraiva@gmail.com
# Data      : 15/04/2023
# Licença   : GNU/GPL v3.0
# ---------------------------------------------------------------------
# Uso : ./install_VsCode.sh
# ---------------------------------------------------------------------

echo "Iniciando a instalação do VsCode..."

#   Importando a chave
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

#   ?
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

#   Checa update
dnf check-update

#   Faz a instalação do VsCode
sudo dnf install -y code
