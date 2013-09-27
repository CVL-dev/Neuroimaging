clear

NAME=display
VERSION=1.5.1
BUILD_DIR=`pwd`/display_build

DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "WARNING: $NAME-$VERSION-sources.tar.gz IS NOT PRESENT! If this is the first run of the script, the build WILL fail later on. If it isn't, you can safely ignore this message."
fi

echo -e "\n\n**********************************************************************************"
echo -e "!!! THIS BUILD OF DISPLAY WILL BUILD FOR THE SPECIFICS OF CVL !!!"
echo -e "**********************************************************************************\n\n"

rm -rf $BUILD_DIR

if [ ! -f /etc/profile.d/modules.sh ]; then echo "ERROR: Modules package is not installed !!!!!"; exit -1; fi;

/etc/profile.d/modules.sh
module load hdf5/1.8.5 2> /tmp/build_mod_load
CHECK_SIZE=`stat -c%s /tmp/build_mod_load`
if [ $CHECK_SIZE -ne 0 ]; then echo "ERROR: Could not locate needed hdf5 package (1.8.5). Please install it and load it: 'module load hdf5/1.8.5' !!!!!"; exit -1
fi

module load netcdf/4.1.1 2> /tmp/build_mod_load
CHECK_SIZE=`stat -c%s /tmp/build_mod_load`
if [ $CHECK_SIZE -ne 0 ]; then
	echo "ERROR: Could not locate needed netcdf package (4.1.1). Please install it and load it: 'module load netcdf/4.1.1' !!!!!"; exit -1
fi

./configure --prefix=$BUILD_DIR/$NAME/$VERSION --with-build-path="/usr/local/netcdf/4.1.1:/usr/local/minc/2.1.0:/usr/local/hdf5/1.8.5:/usr/local/bicpl/1.4.6" --with-minc2 && make install && make clean
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

#cp -r usr $BUILD_DIR/$NAME/$VERSION
rm -rf $NAME-$VERSION-sources.tar.gz

echo "This is a binary build" > $BUILD_DIR/$NAME/$VERSION/readme.txt

mkdir -p ./etc/profile.d
rm -rf ./etc/profile.d/"$NAME"_modules.sh
cat > ./etc/profile.d/"$NAME"_modules.sh <<EOF
#!/bin/bash
echo -n "Checking ${NAME^^} 'modules' requirements..."
if [ ! -f /etc/profile.d/modules.sh ]; then echo -e "FAILED\nERROR: Modules package is not installed !!!!!\n"; fi;

. /etc/profile.d/modules.sh

if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;

module load mesalib 2> /tmp/build_mod_load
module load libjpeg-turbo 2> /tmp/build_mod_load
module load hdf5 2> /tmp/build_mod_load
module load netcdf 2> /tmp/build_mod_load
module load bicpl 2> /tmp/build_mod_load
module load minc 2> /tmp/build_mod_load
module load $NAME/$VERSION 2> /tmp/build_mod_load
CHECK_SIZE=\`stat -c%s /tmp/build_mod_load\`
if [ \$CHECK_SIZE -ne 0 ]; then echo -e "FAILED\nERROR: Could not locate $NAME package. Please install it and load it: 'module load $NAME' !!!!!\n"
fi

rm -rf /tmp/build_mod_load

echo -e "Finished.\n"
EOF
chmod 777 ./etc/profile.d/"$NAME"_modules.sh

cp minc_logo.png $BUILD_DIR/$NAME/$VERSION/
cp display_logo.png $BUILD_DIR/$NAME/$VERSION/

rm -rf $BUILD_DIR/$NAME/$VERSION/bin/display_cvl.sh
cat >  $BUILD_DIR/$NAME/$VERSION/bin/display_cvl.sh <<EOF
#!/bin/sh
module load mesalib 
module load libjpeg-turbo 
module load hdf5 
module load netcdf 
module load bicpl 
module load minc 
Display                                              
EOF
chmod 777 $BUILD_DIR/$NAME/$VERSION/bin/display_cvl.sh

rm -rf $NAME-$VERSION-binaries.tar.gz
tar cvfz $NAME-$VERSION-binaries.tar.gz $BUILD_DIR/$NAME
#rm -rf $BUILD_DIR

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
