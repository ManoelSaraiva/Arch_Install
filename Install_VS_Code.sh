#==========================================================================================================================
#
#                   Script para instalação do VsCode no Fedora  
#                    
#                   https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
#
#                   Data: 15/04/2023
#
#                   Versão: 0.01
#                   
#==========================================================================================================================

echo "Iniciando a instalação do VsCode..."

#   Importando a chave
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

#   ?
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

#   Checa update
dnf check-update

#   Faz a instalação do VsCode
sudo dnf install -y code
