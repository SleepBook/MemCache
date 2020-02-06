# MemCache  

## Intro

The aim of this tool is everyday you feed what you learn to a server and
at certain point(according to Ebbinghaus Curve) these information will feed back to you to reinforce your memory.

## Quick Start
### Server Side
1. Open the `bin/server/server_Memcache.sh` and edit the `PRJ_ROOT` to point to the root dir of this repo
2. Run the script for the first time, it will navigate you to record some info about the server(also a test email will be sent)
3. Add this script to run everyday by linux `crontab` tool. This can be done by
```
crontab -e MIN HRS * * * bash /abs_path/to/this/script
```

### Client Side

## Usage

This program have a client part and server part. The client help to send
your everyday documentation to the server though a Markdown text. And
the server part manage these documentations and make sure they feed back
to you at correct point through Email.

### Client

To use client, run the `client_MemCache.sh` under the `bin` directory.
With no argument, the script will create the documentation for today.
However, the script can take one argument as well when you want to make
up the documentation for any other day, the argument should take form
of:`2016-08-xx`. 

The script will open the local Markdonw editor, when you finish editing
and save the file, the documentation will be automatically uploaded to
server. 

### Server

The server-end script `server_Memcache.sh` is kept under `$PROJECT_ROOT/bin/server` and is supposed to run regularly on server. The server-end keep all the documentation under the `/data` directory and the Documentation is feed back to user through Email(a python script is involved to render the markdown text into html to be send by email.

### Config

First time you run either script, the program will guide you to setup
the configuration.

***Client-End Configuration***

To be exact, on client-end, the infomation you need to provide is the
server's IP and the ssh port. Your account and password on the server
and the path to this program on the server. To provide the server's IP
and User, you need to take the form like:
>xxx@202.xxx.xxx.xxx

And all the information is kept under a configure file `.memcache.rc`
under the Program Root directort.

***Server-End Configuration***

On server-end you need to config an SMTP service. The script need the
smtp's address, the user, the password and the email address to receive
the everyday feed. 

The Information is kept in the `account.py` under `/bin/server`

At Present you need to enter in these information with \"\'\" around.
This should be a bug and i hope to fix this ASAP.

Also, when first time use, you need to edit the script to assign the
path to your project to the PRJ\_ROOT variable. Then this script can be
run without any problem using crontab.

## Issue

~~1. Only cygwin supprot now for client.~~

2. Unblocked Call on Markdown editor invocation

3. Configure the server script need single quote when entering
