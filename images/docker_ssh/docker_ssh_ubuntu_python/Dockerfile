FROM ubuntu

MAINTAINER hai

RUN apt-get update && apt-get upgrade -y

# 安装 SSH
RUN apt-get install -y openssh-server
RUN apt-get install -y openssh-client
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'UseDNS no' >> /etc/ssh/sshd_config
RUN sed -i "s/UsePAM yes/UsePAM no/g" /etc/ssh/sshd_config

# 设置SSH登录密码
RUN echo 'root:wiscom' | chpasswd
RUN /usr/bin/ssh-keygen -A

# 安装基础项
RUN apt-get install -y sudo
RUN apt-get install -y iptables
RUN apt-get install -y inetutils-ping
RUN apt-get install -y net-tools
RUN apt-get install -y vim

# 安装python3
RUN apt-get install -y wget
RUN apt-get install -y gcc automake autoconf libtool make
RUN apt-get install -y openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel zlib-devel
RUN wget https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tgz
RUN tar -zxvf Python-3.5.3.tgz && cd Python-3.5.3/ && ./configure --prefix=/usr/local/ && make && make altinstall
RUN ln -s /usr/local/bin/python3.5 /usr/bin/python3
RUN ln -s /usr/local/bin/pip3.5 /usr/bin/pip3

# 清除残留文件
RUN rm -fr /root/*

EXPOSE 22
ENTRYPOINT /usr/sbin/sshd -D
CMD /bin/bash