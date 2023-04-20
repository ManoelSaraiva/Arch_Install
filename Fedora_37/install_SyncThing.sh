#!/bin/bash
# ---------------------------------------------------------------------
# Script    : install_SyncThing.sh  
# Descrição : Script para instalação do SyncThing no Fedora
# Versão    : 0.01
# Site	    : https://syncthing.net/
# Autor     : Manoel Saraiva - manoeljsaraiva@gmail.com
# Data      : 15/04/2023
# Licença   : GNU/GPL v3.0
# ---------------------------------------------------------------------
# Uso : ./install_SyncThing.sh
# ---------------------------------------------------------------------


#   Inicio
echo "Iniciando a instalação do SyncThing..."
sudo dnf install -y syncthing

#   Ativa o serviço do SyncThing
systemctl enable syncthingk@${$USER}.service

#   Inicia o serviço do SyncThing
systemctl start syncthing@${$USER}.service

#   Mosta o status do serviço
systemctl status syncthing@${$USER}.service


echo "Fim .... " 
