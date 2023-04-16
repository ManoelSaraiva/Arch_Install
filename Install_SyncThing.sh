#==========================================================================================================================
#
#                   Script para instalação do SyncThing no Fedora  
#                    
#                   https://syncthing.net/
#
#                   Data: 15/04/2023
#
#                   Versão: 0.01
#                   
#==========================================================================================================================

#   Inicio
echo "Iniciando a instalação do SyncThing..."
sudo dnf install -y syncthing

#   Ativa o serviço do SyncThing
systemctl enable syncthing@msaraiva.service

#   Inicia o serviço do SyncThing
systemctl start syncthing@msaraiva.service

#   Mosta o status do serviço
systemctl status syncthing@msaraiva.service


echo "Fim .... " 