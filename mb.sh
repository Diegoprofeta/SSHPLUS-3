#!/bin/bash
clear
echo "INFORME SEU NÚMERO (DDD+NÚMERO)"
read NUMERO
echo "QUANTIDADE DE VEZES (1GB = 20VEZES)"
read VEZES
for i in $(seq $VEZES);
do
data=$"msisdn=$NUMERO&campid=4919b47c-f588-4e71-87e3-63>
echo -e "\033[1;32mCONTAGEM:\033[1;37m$i"
done
