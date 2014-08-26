clear

NAME=nimrod
VERSION=4.0.0
BUILD_DIR=`pwd`/nimrod_build

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi

echo -e "\n\n************************************************************************"
echo -e "!!! THIS BUILD OF NIMROD IS TAILORED TOWARDS CVL BUILDING !!!"
echo -e "*************************************************************************\n\n"

rm -rf $BUILD_DIR
if [ ! -f /etc/profile.d/modules.sh ]; then echo "ERROR: Modules package is not installed !!!!!"; exit -1; fi;
mkdir -p $BUILD_DIR

# build
export PYTHONPATH=/usr/local/$NAME/$VERSION/share/$NAME
./configure --prefix=/usr/local/$NAME/$VERSION && make && make install
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi
rm -rf $NAME-$VERSION-sources.tar.gz

# copy over into build dir (needed coz silly nimrod uses prefix to set runtime config instead of more flexible mechanisms) 
cp -r /usr/local/$NAME $BUILD_DIR
rm -rf /usr/local/$NAME

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

rm -rf $NAME-$VERSION-sources.tar.gz
rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR/$NAME
rm -rf $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
