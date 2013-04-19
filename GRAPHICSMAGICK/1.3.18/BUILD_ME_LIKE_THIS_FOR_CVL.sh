clear

echo -e "\n\n*****************************************************************************************************************"
echo -e "!!! THIS BUILD OF GRAPHICS MAGICK HAS TO ADDRESS FILE NAME CLASHES WITH CVL, ADD A README.TXT AND TAR EVERYTHING !!!"
echo -e "*****************************************************************************************************************\n\n"

NAME=graphicsmagick
VERSION=1.3.18
BUILD_DIR=`pwd`/graphicsmagick_build

tar xvzf $NAME-$VERSION-sources.tar.gz
rm -rf $NAME-$VERSION-sources.tar.gz 

rm -rf config
cp -r config.build config
rm -rf $BUILD_DIR

./configure --prefix=$BUILD_DIR/$NAME/$VERSION --enable-shared && make install && make clean

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt
rm -rf $NAME-$VERSION.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR/$NAME

rm -rf config
cp config.cvl config

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************"
