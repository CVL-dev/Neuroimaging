clear

NAME=nifticlib
VERSION=2.0.0
DEST_PATH=${NAME^^}/$VERSION

if [ `pwd | grep /usr/local/src/$DEST_PATH | wc -c` -eq 0 ]; then
        echo "Please copy directory contents to '/usr/local/src/$DEST_PATH' and execute this script there!"
        exit -1;
fi

tar xvzf $NAME-$VERSION-sources.tar.gz
if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

echo -e "\n\n******************************************************************************************************"
echo -e "!!! THIS BUILD OF NIFTI HAS BEEN ALTERED TO PRODUCE SHARED LIBRARIES INSTEAD OF ONLY STATIC ONES !!!"
echo -e "******************************************************************************************************\n\n"

make dist

if [ $? -ne 0 ]; then
        echo "Build aborted! Check for errors..."
        exit -1
fi

rm -rf $NAME-$VERSION-sources.tar.gz

echo -e "\n\n*******************************************************************"
echo -e "\tNOW GO AHEAD AND CVL BUILD ME FROM THE TAR JUST CREATED"
echo -e "*******************************************************************\n\n"
