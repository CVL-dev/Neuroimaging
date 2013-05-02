clear

NAME=graphicsmagick
VERSION=1.3.18
BUILD_DIR=`pwd`/graphicsmagick_build
DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
	echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

echo -e "\n\n*****************************************************************************************************************"
echo -e "!!! THIS BUILD OF GRAPHICS MAGICK HAS TO ADDRESS FILE NAME CLASHES WITH CVL, ADD A README.TXT AND TAR EVERYTHING !!!"
echo -e "*****************************************************************************************************************\n\n"

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi
rm -rf $NAME-$VERSION-sources.tar.gz 

rm -rf config
cp -r config.build config
rm -rf $BUILD_DIR

./configure --prefix=$BUILD_DIR/$NAME/$VERSION --enable-shared && make install && make clean

if [ $? -ne 0 ]; then
	echo "Build aborted! Check for errors..."
        exit -1
fi

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt
rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR/$NAME
rm -rf $BUILD_DIR

rm -rf config
cp config.cvl config

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************"
