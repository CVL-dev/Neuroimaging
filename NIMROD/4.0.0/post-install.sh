#!/bin/bash

# create log
rm -f /tmp/post-install.log
touch /tmp/post-install.log
chmod 666 /tmp/post-install.log

# add nimrod user
useradd -c "nimrod" -m -d /home/nimrod -s /bin/bash -U nimrod &>> /tmp/post-install.log

# init postgresql db (in case)
su -c "su - postgres <<EOF
initdb &>> /tmp/post-install.log
EOF
"

# start postgresql
chkconfig postgresql on &>> /tmp/post-install.log
service postgresql start &>> /tmp/post-install.log
sleep 5s

# create nimrod database and assign it to nimrod user
rm -rf /tmp/db_create.sql
echo "CREATE USER nimrod WITH PASSWORD 'nimrod';" > /tmp/db_create.sql
echo "CREATE DATABASE nimrod WITH OWNER nimrod;" >> /tmp/db_create.sql
chown postgres:postgres /tmp/db_create.sql &>> /tmp/post-install.log

su -c "su - postgres <<EOF
psql -f /tmp/db_create.sql &>> /tmp/post-install.log
EOF
"
rm -rf /tmp/db_create.sql &>> /tmp/post-install.log

# run db objects creation scripts as nimrod
echo "CREATE LANGUAGE plpgsql;" > /tmp/db_create_lang.sql
chown nimrod:nimrod /tmp/db_create_lang.sql &>> /tmp/post-install.log
su -c "su - nimrod <<EOF
psql -f /tmp/db_create_lang.sql &>> /tmp/post-install.log
rm -rf /tmp/db_create_lang.sql &>> /tmp/post-install.log
module load nimrod &>> /tmp/post-install.log
nimrod dbcreate &>> /tmp/post-install.log
EOF
"

# open ports (optional)
#if [ `iptables -S | grep -e "-A INPUT -i lo -j ACCEPT" | wc -c` -eq 0 ]; then
#	iptables -I INPUT 1 -i lo -p all -j ACCEPT &>> /tmp/post-install.log
#fi
#if [ `iptables -S | grep -e "-A INPUT -p tcp -m tcp --dport 8080 -j DROP" | wc -c` -eq 0 ]; then
#	iptables -A INPUT -p tcp --destination-port 8080 -j DROP &>> /tmp/post-install.log
#fi
#iptables-save &>> /tmp/post-install.log
