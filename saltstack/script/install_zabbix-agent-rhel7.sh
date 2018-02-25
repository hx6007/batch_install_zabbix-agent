
#!/bin/bash
# 在Red Hat7系统上安装zabbix-agent-3.4.3

HOSTNAME=145zabbix
ServerIP=192.168.224.142

#关闭selinux
sed -i "s/SELINUX=enforcing/#SELINUX=enforcing\nSELINUX=disabled/g" /etc/selinux/config
setenforce 0

#安装zabbix-agent
rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
yum install zabbix-agent -y

#配置zabbix-agent
sed -i "s/Server=127.0.0.1/#Server=127.0.0.1\nServer=${ServerIP}/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/Hostname=Zabbix server/#Hostname=Zabbix server\nHostname=$HOSTNAME/g" /etc/zabbix/zabbix_agentd.conf

#启动并设置开机启动
systemctl enable zabbix-agent.service
systemctl start zabbix-agent.service 



