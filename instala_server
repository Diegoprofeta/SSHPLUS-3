#!/bin/bash
#===============================#
# \033[1;36m
# \033[1;33m
# \033[1;31m
# \033[0m
#===============================#

instala_fun () {
echo -e "\033[1;33mINSTALANDO... \033[1;32mAGUARDE"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " "
# ACTUALIZA REPOSITORIO
echo -e "\033[1;33m ATUALIZANDO REPOSITORIO... \033[1;32mAGUARDE"
apt-get update -y > /dev/null 2>&1
apt-get upgrade -y > /dev/null 2>&1
apt-get install curl -y > /dev/null 2>&1
apt-get install apache2 -y > /dev/null 2>&1
sed -i "s;Listen 81;Listen 80;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
cat /dev/null > ~/.bash_history && history -c
echo -e " "
# DONWLOAD SERVER
echo -e "\033[1;33m DONWLOAD SERVER... \033[1;32mAGUARDE"
#apt-get install zip -y > /dev/null 2>&1
apt-get install unzip -y > /dev/null 2>&1
apt-get install curl -y > /dev/null 2>&1
[[ ! -d /var/www/html/_S_script ]] && mkdir /var/www/html/_S_script
cd /var/www/html/_S_script
wget https://www.dropbox.com/s/lpexscdu1l1gw7a/teste.zip > /dev/null 2>&1
unzip teste.zip > /dev/null 2>&1
rm -rf teste.zip
cd
# HISTORY
cat /dev/null > ~/.bash_history && history -c
echo -e " "
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;37m Site migrado com sucesso..."
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
rm -rf $HOME/instala_server > /dev/null 2>&1
}

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;31mINSTALADOR DO SITE BY:LUIZ\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -ne "\033[0m"
instala_fun
