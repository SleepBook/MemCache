#!/bin/bash
#Client-end script of this project
#written by oar, 27/08/2016
#revised by oar, 06/02/2020

TMP_DIR=
SERVER_NAME=
SERVER_PATH=

if [ $# == 0 ];then
	filename=$(date +%Y-%m-%d).md
elif [ $# == 1 ];then
	filename=$1.md
else
	echo "illeagal Input"
	exit 1
fi

scp $SERVER_NAME:$SERVER_PATH/data/$filename $TMP_DIR/
$TMP_DIR/$filename || touch $TMP_DIR/$filename
if [[ "$OSTYPE" == "linux_gnu" ]]; then
    xdg-open $TMP_DIR/$filename
elif [[ "$OSTYPE" == "darwin"* ]]; then
    open $TMP_DIR/$filename
elif [[ "$OSTYPE" == "cygwin" ]]; then
    cygstart $TMP_DIR/$filename
fi
read -p "Press anything to Contunue..." tmp
scp $TMP_DIR/$filename  $SERVER_NAME:$SERVER_PATH/data/$filename
echo Success Uploaded
rm $TMP_DIR/$filename
exit 0



