#!/bin/bash
#this is the server-end of the program MemCache
if [ ! -e account.py ];then
	echo Welcome to MemCache Server-End
	echo Following steps will guide you complete the setop
	mkdir -p ../../data
	touch account.py
	read -p "Please enter your smtp server, like: smtp.xx.com:xxx"
	serv_add
	read -p "please enter you account, like: xxx@xx.com" acc
	read -p "please enter your key for the account" key
	read -p "please enter the address you want to receive the
	everyday push" dest
	echo mail_host="$serv_add" > account.py
	echo mail_account="$acc" >> account.py
	echo mail_key="$key" >> account.py
	echo receiver="$dest" >> account.py
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

touch temp.md
echo "### Guten Tag, Heute es gibt pieces fur dich" > temp.md
echo "****" >> temp.md
for dat in $dat1 $dat2 $dat3 $dat4 $dat5 $dat6 $dat7 $dat8
do
	if [ -e ../../data/${dat}.md ];then
		echo "*${dat}*" >> temp.md
		cat temp.md ../../data/${dat}.md > temp2.md
		mv temp2.md temp.md
	fi
done

markdown_py temp.md >> temp.html || echo "Rendering HTML file
unsuccessful"

python sendmail.py temp.html || echo "Send Email Unsuccessful"

echo "Today's job done"
rm temp.html
exit 0
		

