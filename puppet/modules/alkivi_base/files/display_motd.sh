#/bin/sh

for i in `ls /etc/update-motd.d`;
do /etc/update-motd.d/$i;
done
