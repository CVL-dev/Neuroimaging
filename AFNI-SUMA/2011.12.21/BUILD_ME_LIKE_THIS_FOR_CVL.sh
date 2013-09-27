clear

NAME=afni-suma
VERSION=2011.12.21
BUILD_DIR=`pwd`/afni_suma_build

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi

echo -e "\n\n***************************************************************************************"
echo -e "!!! THIS BUILD OF AFNI/SUMA BUILDS THE SOFTWARE FOR CVL PACKAGING !!!"
echo -e "***************************************************************************************\n\n"

rm -rf $NAME-$VERSION-sources.tar.gz
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/$NAME/$VERSION
mkdir -p ./etc/profile.d

make
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

# move stuff to fit CVL format
mv  $BUILD_DIR/$NAME/$VERSION/bin/README* $BUILD_DIR/$NAME/$VERSION

mkdir $BUILD_DIR/$NAME/$VERSION/include
mv  $BUILD_DIR/$NAME/$VERSION/bin/*.h $BUILD_DIR/$NAME/$VERSION/include

mkdir $BUILD_DIR/$NAME/$VERSION/lib
mv  $BUILD_DIR/$NAME/$VERSION/bin/*.a $BUILD_DIR/$NAME/$VERSION/lib
mv  $BUILD_DIR/$NAME/$VERSION/bin/*.so $BUILD_DIR/$NAME/$VERSION/lib

mv $BUILD_DIR/$NAME/$VERSION/bin/funstuff $BUILD_DIR/$NAME/$VERSION/
mv $BUILD_DIR/$NAME/$VERSION/bin/meica.libs $BUILD_DIR/$NAME/$VERSION/
mv $BUILD_DIR/$NAME/$VERSION/bin/*logo*.png $BUILD_DIR/$NAME/$VERSION/

rm -rf ./etc/profile.d/afni-suma_modules.sh
cat > ./etc/profile.d/afni-suma_modules.sh <<EOF
#!/bin/bash
echo -n "Checking AFNI/SUMA 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

module load mesalib 2> /tmp/build_mod_load
module load libjpeg-turbo 2> /tmp/build_mod_load
module load glu 2> /tmp/build_mod_load
module load afni-suma/2011.12.21 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate afni/suma package. Please install it and load it: 'module load afni-suma' !!!!!\n"
fi

rm -rf /tmp/build_mod_load

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/afni-suma_modules.sh

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR
rm -rf $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
