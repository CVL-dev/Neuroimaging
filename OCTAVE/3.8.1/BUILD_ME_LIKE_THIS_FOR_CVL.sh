clear

NAME=octave
VERSION=3.8.1
BUILD_DIR=`pwd`/octave_build

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi

echo -e "\n\n********************************************************************************************"
echo -e "!!! THIS BUILD OF OCTAVE IS TAILORED TOWARDS CVL PACKAGING NEEDS !!!"
echo -e "********************************************************************************************\n\n"

rm -rf $BUILD_DIR

if [ ! -f /etc/profile.d/modules.sh ]; then echo "ERROR: Modules package is not installed !!!!!"; exit -1; fi;

./configure --prefix=$BUILD_DIR/$NAME/$VERSION --with-hdf5-includedir="/usr/local/hdf5/1.8.5/include" --with-hdf5-libdir="/usr/local/hdf5/1.8.5/lib" CPPFLAGS="-I/usr/local/hdf5/1.8.5/include" LDFLAGS="-L/usr/local/hdf5/1.8.5/lib" --without-qhull && make && make install
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

rm -rf $NAME-$VERSION-sources.tar.gz

# move files in subdirectories 
mv $BUILD_DIR/$NAME/$VERSION/lib/$NAME/$VERSION/* $BUILD_DIR/$NAME/$VERSION/lib
rm -rf $BUILD_DIR/$NAME/$VERSION/lib/$NAME/$VERSION
mv $BUILD_DIR/$NAME/$VERSION/libexec/$NAME/$VERSION/exec/x86_64-unknown-linux-gnu/octave-gui $BUILD_DIR/$NAME/$VERSION/bin
rm -rf $BUILD_DIR/$NAME/$VERSION/libexec
mv $BUILD_DIR/$NAME/$VERSION/include/$NAME-$VERSION/octave/* $BUILD_DIR/$NAME/$VERSION/include
rm -rf $BUILD_DIR/$NAME/$VERSION/include/$NAME-$VERSION
echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

mkdir -p ./etc/profile.d
rm -rf ./etc/profile.d/"$NAME"_modules.sh
cat > ./etc/profile.d/"$NAME"_modules.sh <<EOF
#!/bin/bash
echo -n "Checking ${NAME^^} 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

export OCTAVE_HOME=/usr/local/$NAME/$VERSION

module load qt 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "cvl-qt is missing so that you won't be able to use the gui. If you need it please install it and load it: 'module load qt' !!!!!\n"
fi
module load $NAME/$VERSION 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate $NAME package. Please install it and load it: 'module load $NAME' !!!!!\n"
fi

rm -rf /tmp/build_mod_load

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/"$NAME"_modules.sh

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR/$NAME
rm -rf $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
