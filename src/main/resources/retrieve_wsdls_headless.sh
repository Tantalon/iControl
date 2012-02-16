#!/bin/bash

SCRIPTDIR=`dirname $0`
cd $SCRIPTDIR

if [ -d wsdls ]; then
    cd wsdls;
    rm -rf ./*
else
    mkdir wsdls
    cd wsdls
fi

URL="https://${1}/iControl/iControlPortal.cgi"

wget -r --user $2 --password $3 --no-check-certificate -nv -nd -e robots=off $URL
rm iControlPortal.cgi
for FILE in * ; do NEWFILE=`echo $FILE | sed -r 's/^iControlPortal\.cgi\\?WSDL\\=//'` ; NEWFILE="${NEWFILE}.wsdl" ; mv $FILE $NEWFILE ; done
NUMWSDL=`ls -l|wc -l`

