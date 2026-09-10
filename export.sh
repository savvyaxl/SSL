#!/bin/bash

flag=0
if [[ -n $1 ]]
then
    name=$1
else
    echo Please set the certificate name
    exit 1
fi
oldWay=0
if [[ -n $2 ]]
then
    oldWay=1
fi



export name
. ./paths.ini


if [[ $oldWay == 0 ]]
then
    openssl pkcs12 -export -inkey ${key} -in ${crt} -certfile ${root_crt} -out /tmp/${name}.p12
fi
if [[ $oldWay == 1 ]]
then
    openssl pkcs12 -export -certpbe PBE-SHA1-3DES -keypbe PBE-SHA1-3DES -nomac -inkey ${key} -in ${crt} -certfile ${root_crt} -out /tmp/${name}.p12
fi
chmod +r /tmp/${name}.p12
