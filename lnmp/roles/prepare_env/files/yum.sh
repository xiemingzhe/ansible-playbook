#!/bin/bash
[ -d /media/cdrom ] || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom
if [ $? -ne 0 ] ; then
    echo "Please insert cdrom."	
    exit
fi
[ -d /etc/yum.repos.d ] || mkdir -p /etc/yum.repos.d/
cd /etc/yum.repos.d
cat > /etc/yum.repos.d/localyum.repo << FEF
[local]
name=local
baseurl=file:///media/cdrom
gpkcheck=0
enabled=1
FEF

/usr/bin/yum -y clean all &> /dev/null
/usr/bin/yum makecache &> /dev/null
[ $? -eq 0 ] && echo "yum搭建完毕" || echo "yum搭建失败"

