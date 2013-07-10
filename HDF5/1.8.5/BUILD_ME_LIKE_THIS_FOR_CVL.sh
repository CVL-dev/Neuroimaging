clear

NAME=hdf5
VERSION=1.8.5
BUILD_DIR=`pwd`/hdf5_build
DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi
rm -rf $NAME-$VERSION-sources.tar.gz

echo -e "\n\n*********************************************************************************************************"
echo -e "!!! THIS BUILD OF HDF5 HAS TO ADDRESS FILE NAME CLASHES WITH CVL, ADD A README.TXT AND TAR EVERYTHING !!!"
echo -e "*********************************************************************************************************\n\n"

rm -rf config
cp -r config.build config
rm -rf $BUILD_DIR

./configure --prefix=$BUILD_DIR/$NAME/$VERSION && make install && make clean
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

mkdir -p ./etc/profile.d
rm -rf ./etc/profile.d/"$NAME"_modules.sh
cat > ./etc/profile.d/"$NAME"_modules.sh <<EOF
#!/bin/bash
echo -n "Checking ${NAME^^} 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

module load $NAME/$VERSION 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate $NAME package. Please install it and load it: 'module load $NAME' !!!!!\n"
fi

rm -rf /tmp/build_mod_load

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/"$NAME"_modules.sh

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR/$NAME
rm -rf $BUILD_DIR

rm -rf config
cp config.cvl config

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************"
