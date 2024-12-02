#!/bin/bash

flag=0
if [[ -n $1 ]]
then
    name=$1
else
    echo Please set the certificate name
    exit 1
fi

export name
. ./paths.ini

openssl pkcs12 -export -certpbe PBE-SHA1-3DES -keypbe PBE-SHA1-3DES -nomac -inkey ${key} -in ${crt} -certfile ${root_crt} -out /tmp/${name}.p12

