clear

NAME=afni-suma
VERSION=2011.12.21
BUILD_DIR=`pwd`/afni_suma_build

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

#tar xvzf $NAME-$VERSION-sources.tar.gz
#if [ $? -ne 0 ]; then
#        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
#fi

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

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR
rm -rf $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
