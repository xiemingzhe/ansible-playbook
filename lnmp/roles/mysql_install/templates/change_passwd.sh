#!/bin/bash
#该脚本用于更改MySql数据库root密码

passwd={{ MYSQL_PASSWD }}
n=`grep "{{ BASE_DIR }}/bin" /etc/profile |wc -l`

if [ $n -eq 0 ]
then
        echo "export PATH=$PATH:{{ BASE_DIR }}/bin" >> /etc/profile
        source /etc/profile
else
        source /etc/profile
fi

# 修改root密码
{{ BASE_DIR }}/bin/mysql -uroot  -e "alter user 'root'@'localhost' identified by '$passwd'"
# 刷新权限
{{ BASE_DIR }}/bin/mysql -uroot -p$passwd -e "FLUSH PRIVILEGES;"
# 授权root用户拥有所有数据库的所有权限
{{ BASE_DIR }}/bin/mysql -uroot -p$passwd -e "grant all privileges on *.* to root@'%'  identified by '$passwd';"
