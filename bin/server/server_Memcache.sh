#!/bin/bash
#this is the server-end of the program MemCache

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PRJ_ROOT=
export PATH PRJ_ROOT

if [ ! -e ${PRJ_ROOT}/bin/server/account.py ];then
	echo Welcome to MemCache Server-End
	echo Following steps will guide you complete the setop
	mkdir -p ${PRJ_ROOT}/data
	touch ${PRJ_ROOT}/bin/server/account.py
	read -p "Please enter your smtp server, like: smtp.xx.com:xxx" serv
	read -p "please enter you account, like: xxx@xx.com" acc
	read -p "please enter your key for the account" key
	read -p "please enter the address you want to receive the
	everyday push" dest
	
	echo mail_host="$serv" >> ${PRJ_ROOT}/bin/server/account.py
	echo mail_account="$acc" >> ${PRJ_ROOT}/bin/server/account.py
	echo mail_key="$key" >> ${PRJ_ROOT}/bin/server/account.py
	echo receiver="$dest" >> ${PRJ_ROOT}/bin/server/account.py
	echo Setup Complete!
fi

dat1=$(date +%Y-%m-%d)
dat2=$(date --date='1 days ago' '+%Y-%m-%d')
dat3=$(date --date='2 days ago' '+%Y-%m-%d')
dat4=$(date --date='4 days ago' '+%Y-%m-%d')
dat5=$(date --date='7 days ago' '+%Y-%m-%d')
dat6=$(date --date='15 days ago' '+%Y-%m-%d')
dat7=$(date --date='30 days ago' '+%Y-%m-%d')
dat8=$(date --date='60 days ago' '+%Y-%m-%d')

touch ${PRJ_ROOT}/bin/server/temp.md
echo "### Guten Tag, Heute es gibt pieces fur dich" > ${PRJ_ROOT}/bin/server/temp.md
echo "****" >> ${PRJ_ROOT}/bin/server/temp.md
for dat in $dat1 $dat2 $dat3 $dat4 $dat5 $dat6 $dat7 $dat8
do
	if [ -e ${PRJ_ROOT}/data/${dat}.md ];then
		echo "*${dat}*" >> ${PRJ_ROOT}/bin/server/temp.md
		echo "***" >> ${PRJ_ROOT}/bin/server/temp.md
		echo "***" >> ${PRJ_ROOT}/bin/server/temp.md
		cat ${PRJ_ROOT}/bin/server/temp.md ${PRJ_ROOT}/data/${dat}.md > ${PRJ_ROOT}/bin/server/temp2.md
		mv ${PRJ_ROOT}/bin/server/temp2.md ${PRJ_ROOT}/bin/server/temp.md
	fi
done

markdown_py ${PRJ_ROOT}/bin/server/temp.md >> ${PRJ_ROOT}/bin/server/temp.html || echo "Rendering HTML file
unsuccessful"

python ${PRJ_ROOT}/bin/server/sendmail.py ${PRJ_ROOT}/bin/server/temp.html || echo "Send Email Unsuccessful"

echo "Today's job done"
rm ${PRJ_ROOT}/bin/server/temp.html
rm ${PRJ_ROOT}/bin/server/temp.md
exit 0
		

