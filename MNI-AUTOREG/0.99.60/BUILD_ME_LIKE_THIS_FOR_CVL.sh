clear

NAME=mni-autoreg
VERSION=0.99.60
BUILD_DIR=`pwd`/mni_autoreg_build

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi

echo -e "\n\n*********************************************************************"
echo -e "!!! THIS IS A CVL SPECIFIC BUILD OF MNI-AUTOREG !!!"
echo -e "*************************************************************************\n\n"

rm -rf $BUILD_DIR

if [ ! -f /etc/profile.d/modules.sh ]; then echo "ERROR: Modules package is not installed !!!!!"; exit -1; fi;

module load minc/2.1.0 2> /tmp/build_mod_load
CHECK_SIZE=`stat -c%s /tmp/build_mod_load`
if [ $CHECK_SIZE -ne 0 ]; then
	echo "ERROR: Could not locate needed minc package (2.1.0). Please install it and load it: 'module load minc/2.1.0' !!!!!"; exit -1
fi
/etc/profile.d/modules.sh
module load hdf5/1.8.5 2> /tmp/build_mod_load
CHECK_SIZE=`stat -c%s /tmp/build_mod_load`
if [ $CHECK_SIZE -ne 0 ]; then echo "ERROR: Could not locate needed hdf5 package (1.8.5). Please install it and load it: 'module load hdf5/1.8.5' !!!!!"; exit -1
fi

module load netcdf/4.1.1 2> /tmp/build_mod_load
CHECK_SIZE=`stat -c%s /tmp/build_mod_load`
if [ $CHECK_SIZE -ne 0 ]; then
	echo "ERROR: Could not locate needed netcdf package (4.1.1). Please install it and load it: 'module load netcdf/4.1.1' !!!!!"; exit -1
fi

./configure --prefix=$BUILD_DIR/$NAME/$VERSION --with-build-path=/usr/local/netcdf/4.1.1:/usr/local/minc/2.1.0:/usr/local/hdf5/1.8.5 --with-minc2 && make install
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

#cp -r usr $BUILD_DIR/$NAME/$VERSION
rm -rf $NAME-$VERSION-sources.tar.gz

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

mkdir -p ./etc/profile.d
rm -rf ./etc/profile.d/mni_autoreg_modules.sh
cat > ./etc/profile.d/mni_autoreg_modules.sh <<EOF
#!/bin/bash
echo -n "Checking MNI-AUTOREG 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

module load mni-autoreg/0.99.60 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate mni-autoreg package. Please install it and load it: 'module load mni-autoreg' !!!!!\n"
fi

rm -rf /tmp/build_mod_load

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/mni_autoreg_modules.sh

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR/$NAME
rm -rf $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
