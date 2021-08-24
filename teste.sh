#!/bin/bash
#====================================================
#	@kiritosshxd
#====================================================
cor1='\033[41;1;37m'
cor2='\033[44;1;37m'
scor='\033[0m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
SCOLOR='\033[0m'
[[ $(awk -F" " '{print $2}' /usr/lib/licence) == "@KIRITO_SSH" ]] && {
    err_fun () {
        case $1 in
        1)msg -verm "$(fun_trans "Usuário Nulo")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        2)msg -verm "$(fun_trans "Nome muito curto (MIN: 2 CHARACTERS)")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        3)msg -verm "$(fun_trans "Nome muito grande (MAX: 5 CARACTERES)")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        4)msg -verm "$(fun_trans "Senha Nula")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        5)msg -verm "$(fun_trans "Senha muito curta")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        6)msg -verm "$(fun_trans "Senha muito grande")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        7)msg -verm "$(fun_trans "Duração Nula")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        8)msg -verm "$(fun_trans "Duração invalida, utilize números")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        9)msg -verm "$(fun_trans "Duração máxima de um ano")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        11)msg -verm "$(fun_trans "Limite Nulo")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        12)msg -verm "$(fun_trans "Limite invalido, utilize números")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        13)msg -verm "$(fun_trans "Limite máximo de 999")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        14)msg -verm "$(fun_trans "Usuario já Existe")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	    15)msg -verm "$(fun_trans "(Apenas números) GB = Min: 1gb Max: 1000gb")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	    16)msg -verm "$(fun_trans "(Apenas números)")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	    17)msg -verm "$(fun_trans "(Sem imformação - Para Cancelar Digite CRTL + C)")"; sleep 4s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
        esac
    }

    intallv2ray () {
    apt install python3-pip -y 
    source <(curl -sL https://raw.githubusercontent.com/rodrigo12xd/SSHPLUS/master/Modulos/v2ray.sh)
    msg -ama "$(fun_trans "Intalado con Exito")!"
    USRdatabase="/etc/SSHPlus/RegV2ray"
    [[ ! -e ${USRdatabase} ]] && touch ${USRdatabase}
    sort ${USRdatabase} | uniq > ${USRdatabase}tmp
    mv -f ${USRdatabase}tmp ${USRdatabase}
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    protocolv2ray () {
    msg -ama "$(fun_trans "Escolha a opção 3 e coloque o domínio do nosso IP")!"
    msg -bar
    v2ray stream
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    dirapache="/usr/local/lib/ubuntn/apache/ver" && [[ ! -d ${dirapache} ]] && exit
    tls () {
    clear
    echo -e "\E[44;1;37m            Ativar ou Desativar TLS             \E[0m"
    v2ray tls
    echo -e "Enter Para Continuar" && read enter
    fun_v2raymanager
    }
    portv () {
    msg -ama "$(fun_trans "Alterar porta v2ray")!"
    msg -bar
    v2ray port
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    stats () {
    msg -ama "$(fun_trans "Estatísticas de Consumo")!"
    msg -bar
    v2ray stats
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    unistallv2 () {
    source <(curl -sL https://raw.githubusercontent.com/rodrigo12xd/SSHPLUS/master/Modulos/v2ray.sh) --remove > /dev/null 2>&1
    rm -rf /etc/SSHPlus/RegV2ray > /dev/null 2>&1
    echo -e "\n\033[1;32mV2RAY REMOVIDO COM SUCESSO !\033[0m"
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    infocuenta () {
    v2ray info
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    addusr () {
    clear 
    clear
    msg -bar
    msg -tit
    msg -ama "             ADICIONAR USUARIO | UUID V2RAY"
    msg -bar
    ##DIAS
    valid=$(date '+%C%y-%m-%d' -d " +31 days")		  
    ##CORREO		  
    MAILITO=$(cat /dev/urandom | tr -dc '[:alnum:]' | head -c 10)
    ##ADDUSERV2RAY		  
    UUID=`uuidgen`	  
    sed -i '13i\           \{' /etc/v2ray/config.json
    sed -i '14i\           \"alterId": 0,' /etc/v2ray/config.json
    sed -i '15i\           \"id": "'$UUID'",' /etc/v2ray/config.json
    sed -i '16i\           \"email": "'$MAILITO'@gmail.com"' /etc/v2ray/config.json
    sed -i '17i\           \},' /etc/v2ray/config.json
    echo ""
    while true; do
    echo -ne "\e[91m >> Digite um usuário: \033[1;92m"
         read -p ": " nick
         nick="$(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
         if [[ -z $nick ]]; then
         err_fun 17 && continue
         elif [[ "${#nick}" -lt "2" ]]; then
         err_fun 2 && continue
         elif [[ "${#nick}" -gt "5" ]]; then
         err_fun 3 && continue
         fi
         break
    done
    echo -e "\e[91m >> Adicionar UUID: \e[92m$UUID "
    while true; do
         echo -ne "\e[91m >> Duração de UUID (Dias):\033[1;92m " && read diasuser
         if [[ -z "$diasuser" ]]; then
         err_fun 17 && continue
         elif [[ "$diasuser" != +([0-9]) ]]; then
         err_fun 8 && continue
         elif [[ "$diasuser" -gt "360" ]]; then
         err_fun 9 && continue
         fi 
         break
    done
    #Lim
    [[ $(cat /etc/passwd |grep $1: |grep -vi [a-z]$1 |grep -v [0-9]$1 > /dev/null) ]] && return 1
    valid=$(date '+%C%y-%m-%d' -d " +$diasuser days") && datexp=$(date "+%F" -d " + $diasuser days")
    echo -e "\e[91m >> Expira el : \e[92m$datexp "
    ##Registro
    echo "  $UUID | $nick | $valid " >> /etc/SSHPlus/RegV2ray
    Fecha=`date +%d-%m-%y-%R`
    cp /etc/SSHPlus/RegV2ray /etc/SSHPlus/v2ray/RegV2ray-"$Fecha"
    v2ray restart > /dev/null 2>&1
    echo ""
    v2ray info > /etc/SSHPlus/v2ray/confuuid.log
    lineP=$(sed -n '/'${UUID}'/=' /etc/SSHPlus/v2ray/confuuid.log)
    numl1=4
    let suma=$lineP+$numl1
    sed -n ${suma}p /etc/SSHPlus/v2ray/confuuid.log 
    echo ""
    msg -bar
    echo -e "\e[92m           UUID ADICIONADO COM EXITO "
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }

    delusr () {
    clear 
    clear
    invaliduuid () {
    msg -bar
    echo -e "\e[91m                    UUID INVALIDO \n$(msg -bar)"
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    msg -bar
    msg -tit
    msg -ama "             ELIMINAR USUARIO | UUID V2RAY"
    msg -bar
    echo -e "\e[97m               USUARIOS REGISTRADOS"
    echo -e "\e[33m$(cat /etc/SSHPlus/RegV2ray|cut -d '|' -f2,1)" 
    msg -bar
    echo -ne "\e[91m >> Digita UUID para eliminar:\n \033[1;92m " && read uuidel
    [[ $(sed -n '/'${uuidel}'/=' /etc/v2ray/config.json|head -1) ]] || invaliduuid
    lineP=$(sed -n '/'${uuidel}'/=' /etc/v2ray/config.json)
    linePre=$(sed -n '/'${uuidel}'/=' /etc/SSHPlus/RegV2ray)
    sed -i "${linePre}d" /etc/SSHPlus/RegV2ray
    numl1=2
    let resta=$lineP-$numl1
    sed -i "${resta}d" /etc/v2ray/config.json
    sed -i "${resta}d" /etc/v2ray/config.json
    sed -i "${resta}d" /etc/v2ray/config.json
    sed -i "${resta}d" /etc/v2ray/config.json
    sed -i "${resta}d" /etc/v2ray/config.json
    v2ray restart > /dev/null 2>&1
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }

    mosusr_kk() {
    clear 
    clear
    msg -bar
    msg -tit
    msg -ama "         USUARIOS REGISTRADOS | UUID V2RAY"
    msg -bar
    # usersss=$(cat /etc/SSHPlus/RegV2ray|cut -d '|' -f1)
    # cat /etc/SSHPlus/RegV2ray|cut -d'|' -f3
    VPSsec=$(date +%s)
    local HOST="/etc/SSHPlus/RegV2ray"
    local HOST2="/etc/SSHPlus/RegV2ray"
    local RETURN="$(cat $HOST|cut -d'|' -f2)"
    local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
    if [[ -z $RETURN ]]; then
    echo -e "----- NINGUN USER REGISTRADO -----"
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    else
    i=1
    echo -e "\e[97m                 UUID                | USER | EXPIRACION \e[93m"
    msg -bar
    while read hostreturn ; do
    DateExp="$(cat /etc/SSHPlus/RegV2ray|grep -w "$hostreturn"|cut -d'|' -f3)"
    if [[ ! -z $DateExp ]]; then             
    DataSec=$(date +%s --date="$DateExp")
    [[ "$VPSsec" -gt "$DataSec" ]] && EXPTIME="\e[91m[EXPIRADO]\e[97m" || EXPTIME="\e[92m[$(($(($DataSec - $VPSsec)) / 86400))]\e[97m Dias"
    else
    EXPTIME="\e[91m[ S/R ]"
    fi 
    usris="$(cat /etc/SSHPlus/RegV2ray|grep -w "$hostreturn"|cut -d'|' -f2)"
    local contador_secuencial+="\e[93m$hostreturn \e[97m|\e[93m$usris\e[97m|\e[93m $EXPTIME \n"           
          if [[ $i -gt 30 ]]; then
    	      echo -e "$contador_secuencial"
    	  unset contador_secuencial
    	  unset i
    	  fi
    let i++
    done <<< "$IDEUUID"
    [[ ! -z $contador_secuencial ]] && {
    linesss=$(cat /etc/SSHPlus/RegV2ray | wc -l)
    	      echo -e "$contador_secuencial \n Numero de Registrados: $linesss"
    	}
    fi
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    lim_port () {
    clear 
    clear
    msg -bar
    msg -tit
    msg -ama "          LIMITAR MB X PORT | UUID V2RAY"
    msg -bar
    ###VER
    estarts () {
    VPSsec=$(date +%s)
    local HOST="/etc/SSHPlus/v2ray/lisportt.log"
    local HOST2="/etc/SSHPlus/v2ray/lisportt.log"
    local RETURN="$(cat $HOST|cut -d'|' -f2)"
    local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
    if [[ -z $RETURN ]]; then
    echo -e "----- NINGUN PUERTO REGISTRADO -----"
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    else
    i=1
    while read hostreturn ; do
    iptables -n -v -L > /etc/SSHPlus/v2ray/data1.log 
    statsss=$(cat /etc/SSHPlus/v2ray/data1.log|grep -w "tcp spt:$hostreturn quota:"|cut -d' ' -f3,4,5)
    gblim=$(cat /etc/SSHPlus/v2ray/lisportt.log|grep -w "$hostreturn"|cut -d'|' -f2)
    local contador_secuencial+="         \e[97mPUERTO: \e[93m$hostreturn \e[97m|\e[93m$statsss \e[97m|\e[93m $gblim GB  \n"          
          if [[ $i -gt 30 ]]; then
    	      echo -e "$contador_secuencial"
    	  unset contador_secuencial
    	  unset i
    	  fi
    let i++
    done <<< "$IDEUUID"
    [[ ! -z $contador_secuencial ]] && {
    linesss=$(cat /etc/SSHPlus/v2ray/lisportt.log | wc -l)
    	      echo -e "$contador_secuencial \n Puertos Limitados: $linesss"
    	}
    fi
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh 
    }
    ###LIM
    liport () {
    while true; do
         echo -ne "\e[91m >> Digite Port a Limitar:\033[1;92m " && read portbg
         if [[ -z "$portbg" ]]; then
         err_fun 17 && continue
         elif [[ "$portbg" != +([0-9]) ]]; then
         err_fun 16 && continue
         elif [[ "$portbg" -gt "1000" ]]; then
         err_fun 16 && continue
         fi 
         break
    done
    while true; do
         echo -ne "\e[91m >> Digite Cantidad de GB:\033[1;92m " && read capgb
         if [[ -z "$capgb" ]]; then
         err_fun 17 && continue
         elif [[ "$capgb" != +([0-9]) ]]; then
         err_fun 15 && continue
         elif [[ "$capgb" -gt "1000" ]]; then
         err_fun 15 && continue
         fi 
         break
    done
    uml1=1073741824
    gbuser="$capgb"
    let multiplicacion=$uml1*$gbuser
    sudo iptables -I OUTPUT -p tcp --sport $portbg -j DROP
    sudo iptables -I OUTPUT -p tcp --sport $portbg -m quota --quota $multiplicacion -j ACCEPT
    iptables-save > /etc/iptables/rules.v4
    echo ""
    echo -e " Port Seleccionado: $portbg | Cantidad de GB: $gbuser"
    echo ""
    echo " $portbg | $gbuser | $multiplicacion " >> /etc/SSHPlus/v2ray/lisportt.log 
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    ###RES
    resdata () {
    VPSsec=$(date +%s)
    local HOST="/etc/SSHPlus/v2ray/lisportt.log"
    local HOST2="/etc/SSHPlus/v2ray/lisportt.log"
    local RETURN="$(cat $HOST|cut -d'|' -f2)"
    local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
    if [[ -z $RETURN ]]; then
    echo -e "----- NINGUN PUERTO REGISTRADO -----"
    return 0
    else
    i=1
    while read hostreturn ; do
    iptables -n -v -L > /etc/SSHPlus/v2ray/data1.log 
    statsss=$(cat /etc/SSHPlus/v2ray/data1.log|grep -w "tcp spt:$hostreturn quota:"|cut -d' ' -f3,4,5)
    gblim=$(cat /etc/SSHPlus/v2ray/lisportt.log|grep -w "$hostreturn"|cut -d'|' -f2)
    local contador_secuencial+="         \e[97mPUERTO: \e[93m$hostreturn \e[97m|\e[93m$statsss \e[97m|\e[93m $gblim GB  \n"  
            
          if [[ $i -gt 30 ]]; then
    	      echo -e "$contador_secuencial"
    	  unset contador_secuencial
    	  unset i
    	  fi
    let i++
    done <<< "$IDEUUID"

    [[ ! -z $contador_secuencial ]] && {
    linesss=$(cat /etc/SSHPlus/v2ray/lisportt.log | wc -l)
    	      echo -e "$contador_secuencial \n Puertos Limitados: $linesss"
    	}
    fi
    msg -bar

    while true; do
         echo -ne "\e[91m >> Digite Puerto a Limpiar:\033[1;92m " && read portbg
         if [[ -z "$portbg" ]]; then
         err_fun 17 && continue
         elif [[ "$portbg" != +([0-9]) ]]; then
         err_fun 16 && continue
         elif [[ "$portbg" -gt "1000" ]]; then
         err_fun 16 && continue
         fi 
         break
    done
    invaliduuid () {
    msg -bar
    echo -e "\e[91m                PUERTO INVALIDO \n$(msg -bar)"
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh
    }
    [[ $(sed -n '/'${portbg}'/=' /etc/SSHPlus/v2ray/lisportt.log|head -1) ]] || invaliduuid
    gblim=$(cat /etc/SSHPlus/v2ray/lisportt.log|grep -w "$portbg"|cut -d'|' -f3)
    sudo iptables -D OUTPUT -p tcp --sport $portbg -j DROP
    sudo iptables -D OUTPUT -p tcp --sport $portbg -m quota --quota $gblim -j ACCEPT
    iptables-save > /etc/iptables/rules.v4
    lineP=$(sed -n '/'${portbg}'/=' /etc/SSHPlus/v2ray/lisportt.log)
    sed -i "${linePre}d" /etc/SSHPlus/v2ray/lisportt.log
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh 
    }
    ## MENU
    echo -ne "\033[1;32m [1] > " && msg -azu "$(fun_trans "LIMITAR DATA x PORT") "
    echo -ne "\033[1;32m [2] > " && msg -azu "$(fun_trans "RESETEAR DATA DE PORT") "
    echo -ne "\033[1;32m [3] > " && msg -azu "$(fun_trans "VER DATOS CONSUMIDOS") "
    echo -ne "$(msg -bar)\n\033[1;32m [0] > " && msg -bra "\e[97m\033[1;41m VOLVER \033[1;37m"
    msg -bar
    selection=$(selection_fun 3)
    case ${selection} in
    1)liport ;;
    2)resdata;;
    3)estarts;;
    0)
    ${SCPinst}/v2ray.sh
    ;;
    esac
    }

    #.
    limpiador_activador () {
    unset PIDGEN
    PIDGEN=$(ps aux|grep -v grep|grep "limv2ray")
    if [[ ! $PIDGEN ]]; then
    screen -dmS limv2ray watch -n 21600 limv2ray
    else
    #killall screen
    screen -S limv2ray -p 0 -X quit
    fi
    unset PID_GEN
    PID_GEN=$(ps x|grep -v grep|grep "limv2ray")
    [[ ! $PID_GEN ]] && PID_GEN="\e[91m [ DESACTIVADO ] " || PID_GEN="\e[92m [ ACTIVADO ] "
    statgen="$(echo $PID_GEN)"
    clear 
    clear
    msg -bar
    msg -tit
    msg -ama "          ELIMINAR EXPIRADOS | UUID V2RAY"
    msg -bar
    echo ""
    echo -e "                    $statgen " 
    echo "" 						
    msg -bar
    msg -ne "Enter Para Continuar" && read enter
    ${SCPinst}/v2ray.sh

    }

    selection_fun () {
    local selection="null"
    local range
    for((i=0; i<=$1; i++)); do range[$i]="$i "; done
    while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
    echo -ne "\033[1;37m$(fun_trans " ► Selecione una Opcion"): " >&2
    read selection
    tput cuu1 >&2 && tput dl1 >&2
    done
    echo $selection
    }

    PID_GEN=$(ps x|grep -v grep|grep "limv2ray")
    [[ ! $PID_GEN ]] && PID_GEN="\e[91m [ DESACTIVADO ] " || PID_GEN="\e[92m [ ACTIVADO ] "
    statgen="$(echo $PID_GEN)"
    SPR & 
    msg -bar3
    msg -bar
    msg -tit

    fun_v2raymanager() {
		while true $x != "ok"; do
			[[ ! -e '/home/sshplus' ]] && exit 0
			clear
			echo -e "\E[44;1;37m                GERENCIADOR V2RAY                 \E[0m\n"
			echo -e "\033[1;32mSERVICO: \033[1;33mOPENSSH \033[1;32mPORTA: \033[1;37m$(grep 'Port' /etc/ssh/sshd_config | cut -d' ' -f2 | grep -v 'no' | xargs)" && sts6="\033[1;32m◉ "
			[[ "$(netstat -tlpn | grep 'docker' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mCHISEL: \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'docker' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts8="\033[1;32m◉ "
			} || {
				sts8="\033[1;31m○ "
			}
			[[ "$(ps x | grep 'slow_dns' | grep -v 'grep'|wc -l)" != '0' ]] && {
				sts9="\033[1;32m◉ "
			} || {
				sts9="\033[1;31m○ "
			}            
			[[ "$(netstat -tlpn | grep 'sslh' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mSSLH: \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'sslh' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts7="\033[1;32m◉ "
			} || {
				sts7="\033[1;31m○ "
			}

			[[ "$(netstat -tlpn | grep 'openvpn' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mOPENVPN: \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'openvpn' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts5="\033[1;32m◉ "
			} || {
				sts5="\033[1;31m○ "
			}

			[[ "$(netstat -tlpn | grep 'python' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mPROXY SOCKS \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts4="\033[1;32m◉ "
			} || {
				sts4="\033[1;31m○ "
			}
			[[ -e "/etc/stunnel/stunnel.conf" ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mSSL TUNNEL \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'stunnel' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts3="\033[1;32m◉ "
			} || {
				sts3="\033[1;31m○ "
			}
			[[ "$(netstat -tlpn | grep 'dropbear' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mDROPBEAR \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'dropbear' | awk -F ":" {'print $4'} | xargs)"
				sts2="\033[1;32m◉ "
			} || {
				sts2="\033[1;31m○ "
			}
			[[ "$(netstat -tlpn | grep 'squid' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mSQUID \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'squid' | awk -F ":" {'print $4'} | xargs)"
				sts1="\033[1;32m◉ "
			} || {
				sts1="\033[1;31m○ "
			}
			xv2ray=`if netstat -tunlp |grep v2ray 1> /dev/null 2> /dev/null; then
			echo -e "\033[1;32m◉ "
			else
			echo -e "\033[1;31m○ "
			fi`;          
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mINSTALAR V2RAY\033[1;31m
[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mCAMBIAR PROTOCOLO\033[1;31m
[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mACTIVAR TLS\033[1;31m
[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mCAMBIAR PUERTO V2RAY\033[1;31m
[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mAGREGAR USUARIO UUID\033[1;31m
[\033[1;36m06\033[1;31m] \033[1;37m• \033[1;33mELIMINAR USUARIO UUID\033[1;31m
[\033[1;36m07\033[1;31m] \033[1;37m• \033[1;33mMOSTAR USUARIOS REGISTRADOS\033[1;31m
[\033[1;36m08\033[1;31m] \033[1;37m• \033[1;33mINFORMACION DE CUENTAS\033[1;31m
[\033[1;36m09\033[1;31m] \033[1;37m• \033[1;33mESTADISTICAS DE CONSUMO\033[1;31m
[\033[1;36m10\033[1;31m] \033[1;37m• \033[1;33mLIMITADOR POR CONSUMO\e[91m ( BETA x PORT )\033[1;31m
[\033[1;36m11\033[1;31m] \033[1;37m• \033[1;33mLIMPIADOR DE EXPIRADOS ------- $statgen\033[1;31m
[\033[1;36m12\033[1;31m] \033[1;37m• \033[1;33mDESINSTALAR V2RAY\033[1;31m
[\033[1;36m13\033[1;31m] \033[1;37m• \033[1;33mVOLTAR \033[1;32m<\033[1;33m<\033[1;31m< \033[1;31m
[\033[1;36m00\033[1;31m] \033[1;37m• \033[1;33mSAIR \033[1;32m<\033[1;33m<\033[1;31m< \033[0m"

			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			tput civis
			echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "
			read x
			tput cnorm
			clear
			case $x in
			1 | 01)
				intallv2ray
				;;
			2 | 02)
				protocolv2ray
				;;
			3 | 03)
				tls
				;;
			4 | 04)
				portv
				;;
			5 | 05)
				addusr
				;;
			6 | 06)
				delusr
				;;
			7 | 07)
				mosusr_kk
				;;
		    8 | 08)
				infocuenta
                ;;              
		    9 | 09)
				stats
				;;
		    10 | 10)
				lim_port
				;;                
			11 | 11)
				limpiador_activador
				;;
            12 | 12)
				unistallv2
				;;
            13 | 13)
				fun_conexao
				;;

			0 | 00)
				echo -e "\033[1;31mSaindo...\033[0m"
				sleep 2
				clear
				exit
				;;
			*)
				echo -e "\033[1;31mOpcao invalida !\033[0m"
				sleep 2
				;;
			esac
		done
	}
    fun_v2raymanager

}
