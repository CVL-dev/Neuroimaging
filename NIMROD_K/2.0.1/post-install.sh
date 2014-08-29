#!/bin/bash

# create log
rm -f /tmp/post-install.log
touch /tmp/post-install.log
chmod 666 /tmp/post-install.log

java -jar /usr/local/nimrod_k/2.0.1/nimrodk-2.0.1.jar -a --prefix=/usr/local/kepler/2.4/lib >> /tmp/post-install.log
