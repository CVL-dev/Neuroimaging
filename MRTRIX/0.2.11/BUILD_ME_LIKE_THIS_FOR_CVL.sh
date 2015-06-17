clear

NAME=mrtrix
VERSION=0.2.11
BUILD_DIR=`pwd`/mrtrix_build

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
echo -e "!!! THIS BUILD OF MRTRIX BUILDS THE SOFTWARE FOR CVL PACKAGING !!!"
echo -e "*****************************************************************************\n\n"

rm -rf $NAME-$VERSION-sources.tar.gz
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/$NAME/$VERSION/lib

./build clean
./build linkto=
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi
mv ./bin $BUILD_DIR/$NAME/$VERSION
cp ./lib/*.so $BUILD_DIR/$NAME/$VERSION/lib

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR
rm -rf $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
