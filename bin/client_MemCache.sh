#!/bin/bash
#Client-end script of this project
#written by oar, 27/08/2016

test -e ../.memcache.rc
if [ $? != 0 ];then
	echo Welcome to MemCache
	echo "This seems to be your first time here, following step will
	guide you complete the setup work"
	touch ../.memcache.rc
	read -p "Please enter the server address:" server_add
	echo server_add="$server_add" > ../.memcache.rc
	read -p "please enter the key on server" server_key
	echo server_key=$server_key >> ../.memcache.rc
	read -p "Please enter the ssh port on server:" server_port
	echo server_port=$server_port >> ../.memcache.rc
	read -p "Please enter the position on server" server_path
	echo server_path="$server_path" >> ../.memcache.rc
	echo export server_add >> ../.memcache.rc
	echo export server_key >> ../.memcache.rc
	echo export server_port >> ../.memcache.rc
	echo export server_path >> ../.memcache.rc
fi

source ../.memcache.rc

if [ $# == 0 ];then
	filename=$(date +%Y-%m-%d).md
elif [ $# == 1 ];then
	filename=$1.md
else
	echo "illeagal Input"
	exit 1
fi

scp -P $server_port $server_add:$server_path/data/$filename ../data/$filename || touch ../data/$filename
cygstart ../data/$filename
read -p "Press anything to Contunue..." tmp
scp -P $server_port ../data/$filename $server_add:$server_path/data/$filename
echo Success Uploaded
exit 0
