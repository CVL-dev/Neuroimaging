clear

NAME=ants
VERSION=1.9.4
CMAKE_2_8_12=`pwd`/cmake-2.8.12
SOURCES=`pwd`/sources
BUILD_DIR=`pwd`/ants_build

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi

echo -e "\n\n*********************************************************************************"
echo -e "!!! THIS BUILD OF ANTS BUILDS THE SOFTWARE FOR CVL PACKAGING !!!"
echo -e "!!! NOTE: YOU WILL NEED TO HAVE A LOCAL INSTALL OF CMAKE VERSION 1.8.4 OR HIGHER !!!"
echo -e "**********************************************************************************\n\n"

rm -rf $NAME-$VERSION-sources.tar.gz
#rm -rf $BUILD_DIR
mkdir -p ./etc/profile.d

mkdir -p $BUILD_DIR/$NAME/$VERSION

#$CMAKE_2_8_12/bin/cmake $SOURCES
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi
#make -j 4
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi
echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt
cp $SOURCES/Scripts/* $BUILD_DIR/$NAME/$VERSION/bin

rm -rf ./etc/profile.d/ants_modules.sh
cat > ./etc/profile.d/ants_modules.sh <<EOF
#!/bin/bash
echo -n "Checking ANTS 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

module load ants/1.9.4 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate ants package. Please install it and load it: 'module load ants' !!!!!\n"
fi

rm -rf /tmp/build_mod_load
export ANTSPATH=/usr/local/$NAME/$VERSION/bin

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/ants_modules.sh

TARGET=`pwd`/$NAME-$VERSION-binaries.tar.gz
rm -rf $TARGET
cd $BUILD_DIR
tar cvfz $TARGET $NAME/$VERSION/bin $NAME/$VERSION/lib $NAME/$VERSION/readme.txt
#rm -rf $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
