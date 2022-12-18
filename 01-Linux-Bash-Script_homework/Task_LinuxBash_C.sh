#!/bin/bash


DATE=$(date +"%d-%m-%Y_%I-%M-%S")
FILE_PATH="root"
FILE_NAME=$1
COPY_PATH="opt"

echo $COPY_PATH

function check {

if [[ $1 ]]; then
echo "file copied success"
else
echo "file did not copied"
fi

}


if [[ $FILE_NAME ]]
then
zip $FILE_NAME-$DATE.zip $FILE_NAME
/usr/bin/echo "$DATE: file /$FILE_PATH/$FILE_NAME was backuped to /$COPY_PATH/$FILE_NAME-$DATE.zip" >> copy_add_del_files.txt
cp /$FILE_PATH/$FILE_NAME-$DATE.zip /$COPY_PATH
check "/COPY_PATH/$FILE_NAME-$DATE.zip" 
else
echo "file does not exist"
fi
