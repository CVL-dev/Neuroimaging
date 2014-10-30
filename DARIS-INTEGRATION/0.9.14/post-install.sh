#!/bin/bash

chmod 755 /usr/local/daris-integration/0.9.14/bin/*.sh

if [ ! -f /etc/mediaflux/servicerc ]; then
	if [ ! -d /etc/mediaflux ]; then
		mkdir /etc/mediaflux
	fi
	echo "#!/bin/bash" > /etc/mediaflux/servicerc
	echo "echo \"This is not the real '/etc/mediaflux/servicerc'\"" >> /etc/mediaflux/servicerc
	echo "echo \"It is only there to satify the daris-integration script!\"" >> /etc/mediaflux/servicerc
	echo "echo \"Replace it with the proper content!\"" >> /etc/mediaflux/servicerc
	chmod 766 /etc/mediaflux/servicerc
fi
