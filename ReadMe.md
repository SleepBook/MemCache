# MemCache  

## Intro

The aim of this tool is everyday you feed what you learn to a server and
at certain point(according to Ebbinghaus Curve) these information will feed back to you to reinforce your memory.

## Quick Start
### Server Side
***Pre-requsite***

    the python markdown package should be installed
1. Open the `bin/server/server_Memcache.sh` and edit the `PRJ_ROOT` to point to the root dir of this repo
2. Run the script for the first time, it will navigate you to record some info about the server(also a test email will be sent)
3. Add this script to run everyday by linux `crontab` tool. This can be done by
```
crontab -e MIN HRS * * * bash /abs_path/to/this/script
```

### Client Side
***Pre-requsite***
1. The server should have an ssh name on the client mahcine, this can be addes in the .ssh/config file
2. A default program to open .md files

Open the `client_MemCache.sh` file the populate 3 variables:

`TMP_DIR` should point to the directory where temp files are put
`SERVER_NAME` is the remote server's ssh name
`SERVER_PATH` is the absolute path of the MemCache repo on the remote server

Then everytime you ready to take a quick note for today's study, just run the `client_MemCache.sh` script you are good to roll! Note teh script can take either no parameter or one. The one parameter is useful when you want to make for previous days' study, and when you do this, your filename should comply the format of `YYYY-MM-DD`

## Structure

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

First time you run the server script, the program will guide you to setup
the account information.

***Server-End Configuration***

On server-end you need to config an SMTP service. The script need the
smtp's address, the user, the password and the email address to receive
the everyday feed. 

The Information is kept in the `account.py` under `/bin/server`

At Present you need to enter in these information with \"\'\" around.

Note some email server provider will deny the connection from this app. Usually you need to config with your email service provider to allow less-secure smtp connection.


## Issue

~~1. Only cygwin supprot now for client.~~

2. Unblocked Call on Markdown editor invocation

3. Configure the server script need single quote when entering
