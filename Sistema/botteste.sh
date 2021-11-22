#!/bin/bash
echo  -e "Imforme o token"
read token
cd $HOME/BOT
screen -dmS bot_teste ./botssh $token > /dev/null 2>&1