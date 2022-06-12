#!/bin/bash

flag=0
if [[ -n $1 ]]
then
    name=$1
    flag=1
fi

export name
. ./paths.ini

openssl rsa -noout -text  -in ${root_key}
openssl req -noout -text  -in ${root_csr}
openssl x509 -text -noout -in ${root_crt}

if [[ $flag -eq 1 ]]
then
    openssl rsa -noout -text  -in $key
    openssl req -noout -text  -in $csr
    openssl x509 -noout -text -in $crt
fi
#openssl pkcs12 -export -inkey $key -in $crt -certfile ${root_crt} -out /tmp/${name}.p12
