clear

NAME=kepler
VERSION=2.4
BUILD_DIR=`pwd`/binaries

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

echo -e "\n\n******************************************"
echo -e "!!! CVL PACKAGE KEPLER WORKFLOW ENGINE !!!"
echo -e "********************************************\n\n"

mkdir -p ./etc/profile.d

rm -rf ./etc/profile.d/kepler_modules.sh
cat > ./etc/profile.d/kepler_modules.sh <<EOF
#!/bin/bash
echo -n "Checking KEPLER WORKFLOW ENGINE 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

module load mesalib 2> /tmp/build_mod_load
module load kepler/2.4 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate kepler package. Please install it and load it: 'module load kepler' !!!!!\n"
fi

rm -rf /tmp/build_mod_load

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/kepler_modules.sh

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
