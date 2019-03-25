# docker ssh 镜像的使用

## 一、用途

* 用于提供一个可以远程 SSH 登陆的容器

* 独立的编译环境

* 自由操作

* 可控的资源利用率

## 二、启动

* 命令：`docker run -itd --network="server_network" --name="【容器名称】" --hostname="【主机名称】" 【镜像名字】 /bin/bash`

* 例子：`docker run -itd --network="server_network" --name="ubuntu" --hostname="ubuntu" hai/ssh_ubuntu /bin/bash`
