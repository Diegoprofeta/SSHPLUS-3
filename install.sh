#!/bin/bash

install_fun () {
    clear
    echo -e "ATUALIZANDO REPOSITORIO... \033[1;32mAGUARDE"
    apt-get update -y > /dev/null 2>&1
    apt-get upgrade -y > /dev/null 2>&1
    apt-get install curl -y > /dev/null 2>&1
    apt-get install apache2 -y > /dev/null 2>&1
    sed -i "s;Listen 81;Listen 80;g" /etc/apache2/ports.conf
    service apache2 restart > /dev/null 2>&1
    echo -e " "
    echo -e "\033[1;33m DONWLOAD SERVER... \033[1;32mAGUARDE"
    apt-get install zip -y > /dev/null 2>&1
    apt-get install unzip -y > /dev/null 2>&1
    apt-get install curl -y > /dev/null 2>&1
    [[ ! -d /var/www/html/_S_script ]] && mkdir /var/www/html/_S_script
    cd /var/www/html/_S_script
    wget https://www.dropbox.com/s/lpexscdu1l1gw7a/teste.zip > /dev/null 2>&1
    unzip teste.zip > /dev/null 2>&1
    rm -rf teste.zip
    cd
    echo -e " "
    cd
    rm install > /dev/null 2>&1
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e " Site migrado com sucesso..."
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "INSTALADOR DO SITE BY:LUIZ"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -ne "\033[0m"
echo -e "INSTALANDO... AGUARDE"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " "
install_fun
