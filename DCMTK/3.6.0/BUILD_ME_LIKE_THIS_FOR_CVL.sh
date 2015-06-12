clear

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
rm -rf config
cp -r config.build config

./configure --prefix=$BUILD_DIR/$NAME/$VERSION
if [ ! -f config/Makefile.def ]; then
        echo "Configure must have failed. There is no config/Makefile.def"
        exit 1
fi

#replacement to affect build of shared libs
sed -i "/^AR[ ]*=/c\AR = gcc " config/Makefile.def
sed -i "/^ARFLAGS[ ]*=/c\ARFLAGS = -shared -o " config/Makefile.def
sed -i "/^LIBEXT[ ]*=/c\LIBEXT = so " config/Makefile.def
sed -i "/^RANLIB[ ]*=/c\RANLIB = : " config/Makefile.def
sed -i "/^CXXFLAGS[ ]*=/s/$/ -fPIC/" config/Makefile.def
sed -i "/^CFLAGS[ ]*=/s/$/ -fPIC/" config/Makefile.def
sed -i "/^LIBS[ ]*=/s/$/ -lpng/" config/Makefile.def

make install && make install-lib
if [ $? -ne 0 ]; then
        echo "make/install failed"
        exit 1
fi

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR
rm -rf $BUILD_DIR

rm -rf config
cp config.cvl config

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
