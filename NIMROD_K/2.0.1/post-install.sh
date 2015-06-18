#!/bin/bash

# create log
rm -f /tmp/post-install.log
touch /tmp/post-install.log
chmod 666 /tmp/post-install.log

java -jar /usr/local/nimrod_k/2.0.1/nimrodk-2.0.1.jar -a --prefix=/usr/local/kepler/2.4/lib >> /tmp/post-install.log
mv /usr/local/kepler/2.4/lib/nimrodk-2.4.0/lib/bin/nimrodAPI /usr/local/kepler/2.4/lib/nimrodk-2.4.0/lib/bin/nimrodAPIWrapped


rm -rf /usr/local/kepler/2.4/lib/nimrodk-2.4.0/lib/bin/nimrodAPI
cat > /usr/local/kepler/2.4/lib/nimrodk-2.4.0/lib/bin/nimrodAPI <<EOF
#!/bin/bash
export NIMROD_HOSTNAME=$(ifconfig eth0 | sed '/inet\ /!d;s/.*r://g;s/\ .*//g')
export PSQL_LOCATION=$(whereis psql | awk '{print substr($2, 0, length($2)-length("/psql"))}')

if [ ! -f ~/.nimrodrc ]; then touch ~/.nimrodrc; fi;
if [ ! -d ~/.nimrod/experiments ]; then mkdir -p ~/.nimrod/experiments; fi;

/usr/local/kepler/2.4/lib/nimrodk-2.4.0/lib/bin/nimrodAPIWrapped "\$@"
EOF
chmod 777 /usr/local/kepler/2.4/lib/nimrodk-2.4.0/lib/bin/nimrodAPI
