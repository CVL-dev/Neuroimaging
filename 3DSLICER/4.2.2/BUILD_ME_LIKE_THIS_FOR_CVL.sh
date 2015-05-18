clear

NAME=3dslicer
VERSION=4.2.2
BUILD_DIR=`pwd`/binaries

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

echo -e "\n\n******************************************"
echo -e "!!! CREATING BINARY TAR FOR CVL PACKAGE 3D SLICER !!!"
echo -e "********************************************\n\n"

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
