#!/bin/bash

work_path=$(dirname $(readlink -f "$0"))
init_log="${work_path}/logs/init.log"

# 检查是否为初次启动
if [[ ! -f "${init_log}" ]]
then
    echo -e "\e[1;32m\n\t\t===> init <===\n\e[m"

    echo -e "\n>>> creat init.data"
    date >> "${init_log}"

    # 检查是否安装 Docker
    echo -e "\n>>> check docker"
    if [[ $(which docker | wc -l) -eq 0 ]]
    then
        echo "docker ===> installing"

        sudo curl -sSL https://get.docker.com | sh

    else
        echo "docker ===> ok"
    fi
    docker -v | tee -a "${init_log}"

    # 初始化 swarm
    echo -e "\n>>> swarm init"
    docker swarm init | tee -a "${init_log}"

    # 更改 IP值 、 域名 和 名字，初始化时必须要的两个参数：IP、域名、名字
    if [[ $# -eq 3 ]]
    then
        # 更改 IP 值
        old_ip="here.is.my.ip"
        new_ip="$1"
        change_ip_files=`grep ${old_ip} -rl ${work_path}`

        sed -i "s/${old_ip}/${new_ip}/g" ${change_ip_files} > "/dev/null"

        echo -e "\n>>> change IP to \"${new_ip}\""
        echo -e "\n>>> change IP to \"${new_ip}\"" >> "${init_log}"

        # 更改 域名
        old_domain="my_domain.com"
        new_domain="$2"
        change_domain_files=`grep ${old_domain} -rl ${work_path}`

        sed -i "s/${old_domain}/${new_domain}/g" ${change_domain_files} > "/dev/null"

        echo -e "\n>>> change domain to \"${new_domain}\""
        echo -e "\n>>> change domain to \"${new_domain}\"" >> "${init_log}"

        # 更改 服务器名字
        old_name="code_server_name"
        new_name="$3"
        change_name_files=`grep ${old_name} -rl ${work_path}`

        sed -i "s/${old_name}/${new_name}/g" ${change_name_files} > "/dev/null"

        echo -e "\n>>> change code server name to \"${new_name}\""
        echo -e "\n>>> change code server name to \"${new_name}\"" >> "${init_log}"

    else
        echo -e "\n>>> \e[1;31mfailed to init, need two params : auto_run.sh [IP] [domain] [code server name]\e[m"
        rm -f "${init_log}"
    fi

    # 给予相关文件的执行权限
    chmod +x ./tools/*

    # 添加定时任务，自动备份gitlab
    ./tools/add_crontab_task.sh

fi

# 开始部署
if [[ $(which docker | wc -l) -eq 1 &&  -f "${init_log}" ]]
then
    echo -e "\e[1;32m\n\t\t===> deploy <===\n\e[m"
    docker network create --driver=overlay --attachable server_network
    docker stack deploy -c ./code_server_stack.yml csr
fi
