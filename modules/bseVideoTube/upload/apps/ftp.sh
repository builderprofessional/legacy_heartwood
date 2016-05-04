#!/bin/bash
# $1=filename, $2=localdir, $3=remotedir

filename="$1"
localdir="$2"
remotedir="$3"

hostname="ftp27.streamhoster.com"
username="rick_bse"
password="nick0412"
ftp -n $hostname <<EOF
quote USER $username
quote PASS $password

lcd "$localdir"
cd "stream"
mkdir "$remotedir"
cd "$remotedir"
binary
put "$filename"
quit
EOF
