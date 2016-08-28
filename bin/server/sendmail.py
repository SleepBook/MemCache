import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
from email.header import Header
import sys
from account import *
import pdb


message = MIMEText(open(sys.argv[1],'r').read(),'html','utf-8')
message['From']=mail_account
message['To']=receiver
message['Subject']=Header('MemCache Feed','utf-8')

smtpObj=smtplib.SMTP_SSL(mail_host,timeout=300)
smtpObj.login(mail_account,mail_key)
smtpObj.sendmail(mail_account,receiver,message.as_string())
print 'OK'
smtpObj.close()
