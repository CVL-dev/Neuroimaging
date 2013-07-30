clear

NAME=dnifti
VERSION=2.30.0
CURRENT_DIR=`pwd`
BUILD_DIR=`pwd`/build
INSTALL_DIR=`pwd`/install_dir

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi

echo -e "\n\n**********************************************************************"
echo -e "!!! THIS BUILD OF THE DNIFTI BUILDS THE SOFTWARE FOR CVL PACKAGING !!!"
echo -e "************************************************************************\n\n"

rm -rf CMakeLists.txt
cp -f CMakeLists.dnifti CMakeLists.txt

rm -rf $NAME-$VERSION-sources.tar.gz
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR/$NAME/$VERSION/bin
mkdir -p ./etc/profile.d

cd $BUILD_DIR
cmake -DPREFIX:PATH=$INSTALL_DIR/$NAME/$VERSION -DINCLUDEDIR:PATH=./dev-include -DLIBDIR:PATH=./dev-lib $CURRENT_DIR && make install
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

echo "This is a binary build" > $INSTALL_DIR/$NAME/$VERSION/readme.txt

cd $CURRENT_DIR
rm -rf ./etc/profile.d/dnifti_modules.sh
cat > ./etc/profile.d/dnifti_modules.sh <<EOF
#!/bin/bash
echo -n "Checking DNIFTI 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

module load dnifti/2.30.0 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate dnifti package. Please install it and load it: 'module load dnifti' !!!!!\n"
fi

rm -rf /tmp/build_mod_load

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/dnifti_modules.sh

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $INSTALL_DIR
rm -rf $BUILD_DIR
rm -rf $INSTALL_DIR

rm -rf CMakeLists.txt
cp -f CMakeLists.cvl CMakeLists.txt

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"