lear

NAME=dcmtk
VERSION=3.6.0
BUILD_DIR=`pwd`/dcmtk_build

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi

echo -e "\n\n****************************************************************************"
echo -e "!!! THIS BUILD OF THE DICOM Toolkit BUILDS THE SOFTWARE FOR CVL PACKAGING !!!"
echo -e "*****************************************************************************\n\n"

rm -rf $NAME-$VERSION-sources.tar.gz
rm -rf $BUILD_DIR
mkdir -p ./etc/profile.d
rm -rf config
cp -r config.build config

./configure --prefix=$BUILD_DIR/$NAME/$VERSION && make install && make clean
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

rm -rf ./etc/profile.d/dcmtk_modules.sh
cat > ./etc/profile.d/dcmtk_modules.sh <<EOF
#!/bin/bash
echo -n "Checking DCMTK 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

module load dcmtk/3.6.0 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate dcmtk package. Please install it and load it: 'module load dcmtk' !!!!!\n"
fi

rm -rf /tmp/build_mod_load

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/dcmtk_modules.sh

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR
rm -rf $BUILD_DIR

rm -rf config
cp config.cvl config

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
