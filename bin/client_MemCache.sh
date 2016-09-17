#!/bin/bash
#Client-end script of this project
#written by oar, 27/08/2016

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PRJ_ROOT=
export PRJ_ROOT

if [ ! -e ${PRJ_ROOT}/.memcache.rc ];then
	echo Welcome to MemCache
	echo "This seems to be your first time here, following step will
	guide you complete the setup work"
	touch ${PRJ_ROOT}/.memcache.rc
	read -p "Please enter the server address:" server_add
	echo server_add="$server_add" > ${PRJ_ROOT}/.memcache.rc
	read -p "please enter the key on server" server_key
	echo server_key=$server_key >> ${PRJ_ROOT}/.memcache.rc
	read -p "Please enter the ssh port on server:" server_port
	echo server_port=$server_port >> ${PRJ_ROOT}/.memcache.rc
	read -p "Please enter the position on server" server_path
	echo server_path="$server_path" >> ${PRJ_ROOT}/.memcache.rc
	echo export server_add >> ${PRJ_ROOT}/.memcache.rc
	echo export server_key >> ${PRJ_ROOT}/.memcache.rc
	echo export server_port >> ${PRJ_ROOT}/.memcache.rc
	echo export server_path >> ${PRJ_ROOT}/.memcache.rc
fi

source ${PRJ_ROOT}/.memcache.rc

if [ $# == 0 ];then
	filename=$(date +%Y-%m-%d).md
elif [ $# == 1 ];then
	filename=$1.md
else
	echo "illeagal Input"
	exit 1
fi

scp -P $server_port $server_add:$server_path/data/$filename
${PRJ_ROOT}/data/$filename || touch ${PRJ_ROOT}/data/$filename
cygstart ${PRJ_ROOT}/data/$filename
read -p "Press anything to Contunue..." tmp
scp -P $server_port ${PRJ_ROOT}/data/$filename $server_add:$server_path/data/$filename
echo Success Uploaded
exit 0
