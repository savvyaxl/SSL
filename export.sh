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

openssl pkcs12 -export -inkey ${key} -in ${crt} -certfile ${root_crt} -out /tmp/${name}.p12
