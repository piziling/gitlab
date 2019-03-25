 # 代码服务器的简介

## 〇、简介

* 该系统包括了 Gitlab（代码管理）、Poste.io（邮件服务）、Nginx 等

* 可以提供的服务：

  * 高效地管理代码
  
  * GitHub风格
  
  * git远程连接

## 一、部署要求

* **CPU两核，内存4G以上**

* 如何查看 Linux 硬件状况：

  * 查看CPU状况：`cat /proc/cpuinfo`
  
  * 查看内存状况：`cat /proc/meminfo` 或者 `free -h`
  
* 最直观的方法（需要安装 `htop`）：
  
  * Ubuntu系统：`apt-get install -y htop`
  
  * Centos系统：`yum install -y htop`
  
  * 然后直接运行：`htop`

## 二、快速部署

* `git@github.com:bestHAI/gitlab.git`

* `cd gitlab`

* `chmod +x auto_run.sh && ./auto_run.sh 【IP】 【域名】 【名称】` 

## 三、开放的端口

* `22`：Gitlab 的 SSH 端口

* `80`：Gitlab 的 http 默认端口

* `443`：Gitlab 的 https 默认端口

* `9000`：portainer 服务端口

## 四、配置文件

* 以下是几个重要的配置文件的具体路径：

  * `./gitlab/config/gitlab.rb`：Gitlab 的详细配置文件

  * `./gitlab-runner/config/config.toml`：Gitlab-runner 的配置文件

  * `./nginx/nginx.conf`：Nginx 的配置文件

## 五、服务架构

![](https://raw.githubusercontent.com/bestHAI/gitlab/master/index/gitlab/src/server_architecture.png)

## 六、工程目录结构

```text
   ./--- （工程根目录）
      |
      |--- ca/   (生成和保存SSL证书服务)
      |      |
      |      |--- auto_ca.sh (自动生成自签证书的脚本)
      |
      |--- gitlab/   (gitlab的工作目录)
      |      |
      |      |--- backup/  （备份目录）
      |      |
      |      |--- config/  （配置目录）
      |      |      |
      |      |      |--- gitlab.rb  （当前 gitlab 的配置文件）
      |      |      |
      |      |      |--- gitlab.rb.template  （原版 gitlab 的配置文件模板）
      |      |
      |      |--- data/  （数据目录）
      |      |
      |      |--- logs/  （日志目录）
      |
      |--- gitlab-runner/   (gitlab-runner 的工作目录)
      |      |
      |      |--- ci_example/  （ci 的例子）
      |      |
      |      |--- config/  （配置目录）
      |             |
      |             |--- config.toml  （当前 gitlab-runner 的配置文件）
      |
      |--- images/   (构建一些自定义的docker镜像)
      |      |
      |      |--- docker_ssh/  （可以远程 SSH 登陆的镜像，可以开放给成员作为编译用）
      |      |      |
      |      |      |--- docker_ssh_centos/  （纯 centos 系统）
      |      |      |
      |      |      |--- docker_ssh_centos_python/  （预装python 3.5.3 的 centos 系统）
      |      |      |
      |      |      |--- docker_ssh_ubuntu/  （纯 Ubuntu 系统）
      |      |      |
      |      |      |--- docker_ssh_ubuntu_python/  （预装python 3.5.3 的 Ubuntu 系统）
      |      |
      |      |--- gitlab-runner/  （gitlab-runner所需的镜像）
      |             |
      |             |--- python-ai/  （用于python-ai 的 gitlab-runner 的镜像）
      |             |
      |             |--- python-web/  （用于python-web 的 gitlab-runner 的镜像）
      |
      |--- index/  （网站首页目录，提供导航和帮助）
      |      |
      |      |--- gitlab/  （gitlab 帮助文档）
      |      |
      |      |--- start/  （初次进入网站的导航，进行域名解析配置）
      |
      |--- logs/  （系统日志目录，如：系统初始化、定时备份等日志）
      |
      |--- mail/  （邮件服务的工作目录）
      |
      |--- nginx/  （Nginx 均衡负载和反向代理工作目录）
      |      |
      |      |--- nginx.conf  （nginx 配置文件）
      |
      |--- portainer/  （docker可视化服务的工作目录）
      |
      |--- tools/  （存放一些简化系统运维的管理脚本）
      |
      |--- auto_run.sh  （自动启动服务的脚本）
      |
      |--- code_server_stack.yml （整个系统的 yml 部署文件）

```

## 七、日常维护常用命令

* 首次启动： `chmod +x auto_run.sh && ./auto_run.sh 【IP】 【域名】 【名称】`
    
    * 【IP】：部署服务的 ipv4 地址
    
    * 【域名】：服务启动后，通过该域名来访问的，可以按需要来取，但必须符合 **域名** 的命名规则（如：myserver.com，最好都用纯英文小写字母，中间不要有其他符号和空格）
    
    * 【名称】：服务器的名称，这个可以根据需要取，中英文均可
    
* 非初次启动命令： `./auto_run.sh`
    
    * 因为系统比较大，启动服务也较多，会花大概5到10分钟启动
    
* 停止

    * 进入存放管理脚本的目录：`cd tools/`

    * 停止脚本：`./down.sh`
    
    * 再次启动：`./up.sh`

* 监控

    * 进入存放管理脚本的目录：`cd tools/`
    
    * 整体情况：`./ps.sh`
    
    * 单个日志：`./log 【容器名称】`
    
    * 【容器名称】有：nginx、gitlab-ce、gitlab-runner、mail、portainer

* 管理

    * 进入存放管理脚本的目录：`cd tools/`

    * 进入容器脚本：`./exec.sh 【容器名称】 【可选命令】`
    
    * 【容器名称】有：nginx、gitlab-ce、gitlab-runner、mail、portainer
    
    * 【可选命令】：（1）当该参数为空时，会直接进入对应的容器。（2）当该参数不为空时，只返回执行的结果，而不会进入容器内部。

## 八、更多帮助

* [Wiki文档](https://github.com/bestHAI/gitlab/wiki)
