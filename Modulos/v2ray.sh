#! / bin / bash
# EDIT: @kiritossh
# github: https://github.com/Jrohy/multi-v2ray

# 定时 任务 北京 执行 时间 (0 ~ 23)
BEIJING_UPDATE_TIME = 3

# 记录 最 开始 运行 脚本 的 路径
BEGIN_PATH = $ (pwd)

# 安装 方式, 0 为 全新 安装, 1 为 保留 v2ray 配置 更新
INSTALL_WAY = 0

# 定义 操作 变量, 0 为 否, 1 为 是
HELP = 0

REMOVE = 0

CHINÊS = 0

BASE_SOURCE_PATH = "https://multi.netlify.app"

UTIL_PATH = "/ etc / v2ray_util / util.cfg"

UTIL_CFG = "$ BASE_SOURCE_PATH / v2ray_util / util_core / util.cfg"

BASH_COMPLETION_SHELL = "$ BASE_SOURCE_PATH / v2ray"

CLEAN_IPTABLES_SHELL = "$ BASE_SOURCE_PATH / v2ray_util / global_setting / clean_iptables.sh"

#Centos 临时 取消 别名
[[-f / etc / redhat-release && -z $ (echo $ SHELL | grep zsh)]] && unalias -a

[[-z $ (echo $ SHELL | grep zsh)]] && ENV_FILE = ". bashrc" || ENV_FILE = ". Zshrc"

#######Código de cores########
VERMELHO = "31m"
VERDE = "32m"
AMARELO = "33m"
AZUL = "36m"
FUCHSIA = "35m"

colorEcho () {
    COR = $ 1
    echo -e "\ 033 [$ {COLOR} $ {@: 2} \ 033 [0m"
}

####### get params #########
enquanto [[$ #> 0]]; faça
    chave = "$ 1"
    case $ key in
        --retirar)
        REMOVER = 1
        ;;
        -h | --help)
        AJUDA = 1
        ;;
        -k | --keep)
        INSTALL_WAY = 1
        colorEcho $ {BLUE} "mantenha config para atualizar \ n"
        ;;
        --zh)
        CHINÊS = 1
        colorEcho $ {BLUE} "安装 中文 版 .. \ n"
        ;;
        *)
                # opção desconhecida
        ;;
    esac
    shift # passado argumento ou valor
feito
####################################

ajuda(){
    echo "bash v2ray.sh [-h | --help] [-k | --keep] [--remove]"
    echo "-h, --help Mostrar ajuda"
    echo "-k, --manter manter o config.json para atualizar"
    echo "--remove remove v2ray, xray && multi-v2ray"
    echo "sem parâmetros para nova instalação"
    retornar 0
}

removeV2Ray () {
    # 卸载 V2ray 脚本
    bash <(curl -L -s https://multi.netlify.app/go.sh) --remove> / dev / null 2> & 1
    rm -rf / etc / v2ray> / dev / null 2> & 1
    rm -rf / var / log / v2ray> / dev / null 2> & 1

    # 卸载 Raio X 脚本
    bash <(curl -L -s https://multi.netlify.app/go.sh) --remove -x> / dev / null 2> & 1
    rm -rf / etc / xray> / dev / null 2> & 1
    rm -rf / var / log / xray> / dev / null 2> & 1

    # 清理 v2ray 相关 iptable 规则
    bash <(curl -L -s $ CLEAN_IPTABLES_SHELL)

    # 卸载 multi-v2ray
    pip uninstall v2ray_util -y
    rm -rf /usr/share/bash-completion/completions/v2ray.bash> / dev / null 2> & 1
    rm -rf / usr / share / bash-completed / completions / v2ray> / dev / null 2> & 1
    rm -rf / usr / share / bash-completed / completions / xray> / dev / null 2> & 1
    rm -rf /etc/bash_completion.d/v2ray.bash> / dev / null 2> & 1
    rm -rf / usr / local / bin / v2ray> / dev / null 2> & 1
    rm -rf / etc / v2ray_util> / dev / null 2> & 1

    # 删除 v2ray 定时 更新 任务
    crontab -l | sed '/ SHELL = / d; / v2ray / d' | sed '/ SHELL = / d; / xray / d'> crontab.txt
    crontab crontab.txt> / dev / null 2> & 1
    rm -f crontab.txt> / dev / null 2> & 1

    if [[$ {PACKAGE_MANAGER} == 'dnf' || $ {PACKAGE_MANAGER} == 'yum']]; então
        systemctl restart crond> / dev / null 2> & 1
    outro
        systemctl reiniciar cron> / dev / null 2> & 1
    fi

    # 删除 multi-v2ray 环境 变量
    sed -i '/ v2ray / d' ~ / $ ENV_FILE
    sed -i '/ xray / d' ~ / $ ENV_FILE
    fonte ~ / $ ENV_FILE

    colorEcho $ {GREEN} "desinstalação bem-sucedida!"
}

closeSELinux () {
    # 禁用 SELinux
    if [-s / etc / selinux / config] && grep 'SELINUX = enforcing' / etc / selinux / config; então
        sed -i 's / SELINUX = enforcing / SELINUX = disabled / g' / etc / selinux / config
        setenforce 0
    fi
}

checkSys () {
    # 检查 是否 为 Root
    [$ (id -u)! = "0"] && {colorEcho $ {RED} "Erro: Você deve ser root para executar este script"; saída 1; }

    if [[`command -v apt-get`]]; então
        PACKAGE_MANAGER = 'apt-get'
    elif [[`command -v dnf`]]; então
        PACKAGE_MANAGER = 'dnf'
    elif [[`command -v yum`]]; então
        PACKAGE_MANAGER = 'yum'
    outro
        colorEcho $ RED "Não suporta OS!"
        saída 1
    fi
}

# 安装 依赖
installDependent () {
    if [[$ {PACKAGE_MANAGER} == 'dnf' || $ {PACKAGE_MANAGER} == 'yum']]; então
        $ {PACKAGE_MANAGER} instalar socat crontabs bash-completar que -y
    outro
        Atualização de $ {PACKAGE_MANAGER}
        $ {PACKAGE_MANAGER} instalar socat cron bash-conclusão ntpdate -y
    fi

    #install python3 & pip
    fonte <(curl -sL https://python3.netlify.app/install.sh)
}

updateProject () {
    [[! $ (digite pip 2> / dev / null)]] && colorEcho $ RED "pip no install!" && saída 1

    pip install -U v2ray_util

    if [[-e $ UTIL_PATH]]; então
        [[-z $ (cat $ UTIL_PATH | grep lang)]] && echo "lang = en" >> $ UTIL_PATH
    outro
        mkdir -p / etc / v2ray_util
        curl $ UTIL_CFG> $ UTIL_PATH
    fi

    [[$ CHINESE == 1]] && sed -i "s / lang = en / lang = zh / g" $ UTIL_PATH

    rm -f / usr / local / bin / v2ray> / dev / null 2> & 1
    ln -s $ (que v2ray-util) / usr / local / bin / v2ray
    rm -f / usr / local / bin / xray> / dev / null 2> & 1
    ln -s $ (que v2ray-util) / usr / local / bin / xray

    # 移除 旧 的 v2ray bash_completion 脚本
    [[-e /etc/bash_completion.d/v2ray.bash]] && rm -f /etc/bash_completion.d/v2ray.bash
    [[-e /usr/share/bash-completion/completions/v2ray.bash]] && rm -f /usr/share/bash-completion/completions/v2ray.bash

    # 更新 v2ray bash_completion 脚本
    curl $ BASH_COMPLETION_SHELL> / usr / share / bash-completed / completions / v2ray
    curl $ BASH_COMPLETION_SHELL> / usr / share / bash-completed / completions / xray
    if [[-z $ (echo $ SHELL | grep zsh)]]; então
        source / usr / share / bash-completed / completions / v2ray
        source / usr / share / bash-completed / completions / xray
    fi
    
    # 安装 V2ray 主程序
    [[$ {INSTALL_WAY} == 0]] && bash <(curl -L -s https://multi.netlify.app/go.sh)
}

# 时间 同步
timeSync () {
    if [[$ {INSTALL_WAY} == 0]]; então
        echo -e "$ {Info} Sincronizando tempo .. $ {Font}"
        if [[`command -v ntpdate`]]; então
            ntpdate pool.ntp.org
        elif [[`command -v chronyc`]]; então
            chronyc -a makestep
        fi

        se [[$? -eq 0]]; então
            echo -e "$ {OK} Sucesso de sincronização de tempo $ {Font}"
            echo -e "$ {OK} agora:` date -R` $ {Font} "
        fi
    fi
}

profileInit () {

    # 清理 v2ray 模块 环境 变量
    [[$ (grep v2ray ~ / $ ENV_FILE)]] && sed -i '/ v2ray / d' ~ / $ ENV_FILE && fonte ~ / $ ENV_FILE

    # 解决 Python3 中文 显示 问题
    [[-z $ (grep PYTHONIOENCODING = utf-8 ~ / $ ENV_FILE)]] && echo "export PYTHONIOENCODING = utf-8" >> ~ / $ ENV_FILE && source ~ / $ ENV_FILE

    # 全新 安装 的 新 配置
    [[$ {INSTALL_WAY} == 0]] && v2ray novo

    echo ""
}

installFinish () {
    # 回到 原点
    cd $ {BEGIN_PATH}

    [[$ {INSTALL_WAY} == 0]] && WAY = "instalar" || WAY = "atualizar"
    colorEcho $ {GREEN} "sucesso de multi-v2ray $ {WAY}! \ n"

    if [[$ {INSTALL_WAY} == 0]]; então
        Claro

        echo -e "\ n \ 033 [1; 32mV2RAY INSTALADO COM SUCESSO! \ 033 [0m"
        informação v2ray

        echo -e "Por favor insira o comando 'v2ray' para gerenciar v2ray \ n"
    fi
}


a Principal() {

    [[$ {HELP} == 1]] && ajuda && retorno

    [[$ {REMOVE} == 1]] && removeV2Ray && return

    [[$ {INSTALL_WAY} == 0]] && colorEcho $ {BLUE} "nova instalação \ n"

    checkSys

    installDependent

    fechar SELinux

    timeSync

    updateProject

    profileInit

    installFinish
}

a Principal
