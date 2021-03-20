#!/bin/bash
clear
echo "INFORME SEU NÚMERO (DDD+NÚMERO)"
read SEU NUMERO
echo "QUANTIDADE DE VEZES (1GB = 20VEZES)"
read VEZES
for i in $(seq $VEZES);
do
data=$"msisdn=$SEU NUMERO&campid=4919b47c-f588-4e71-87e3-639b3af92e4d&opCode=VV" && site=$"http://interatividade.vivo.ddivulga.com/carrotProcess" && curl "${site}" -d "${data}"
echo $i;
done
