FROM centos

MAINTAINER hai

RUN yum update -y

# 安装 SSH
RUN yum install -y openssh-server
RUN yum install -y openssh-clients
RUN mkdir /var/run/sshd
RUN echo 'UseDNS no' >> /etc/ssh/sshd_config

# 设置SSH登录密码
RUN echo 'root:wiscom' | chpasswd
RUN /usr/bin/ssh-keygen -A

# 安装基础项
RUN yum install -y sudo
RUN yum install -y net-tools
RUN yum install -y iptables
RUN yum install -y vim

# 清除残留文件
RUN rm -fr /root/*

EXPOSE 22
ENTRYPOINT /usr/sbin/sshd -D
CMD /bin/bash