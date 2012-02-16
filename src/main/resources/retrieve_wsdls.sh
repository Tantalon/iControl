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

read -p "What is the name or IP of your BIG-IP? : " BIGIP
read -p "What username should I login to the BIG-IP? : " BIGIPUSERNAME
read -sp "What password should I use for the BIG-IP?: " BIGIPPASSWORD

URL="https://${BIGIP}/iControl/iControlPortal.cgi"

echo
echo "Connecting to $URL as ${BIGIPUSERNAME}"

wget -r --user $BIGIPUSERNAME --password $BIGIPPASSWORD --no-check-certificate -nv -nd -e robots=off $URL
rm iControlPortal.cgi
for FILE in * ; do NEWFILE=`echo $FILE | sed -r 's/^iControlPortal\.cgi\\?WSDL\\=//'` ; NEWFILE="${NEWFILE}.wsdl" ; mv $FILE $NEWFILE ; done
NUMWSDL=`ls -l|wc -l`
echo "${NUMWSDL} wsdl retrieved"
