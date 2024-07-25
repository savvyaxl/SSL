#!/bin/bash

flag=0
if [[ -n $1 ]]
then
    name=$1
    flag=1
fi

export name
. ./paths.ini

echo 'root key'
openssl rsa -noout -text  -in ${root_key}
echo ''
echo ''
echo 'root csr'
openssl req -noout -text  -in ${root_csr}
echo ''
echo ''
echo 'root crt'
openssl x509 -text -noout -in ${root_crt}
echo ''
echo ''

if [[ $flag -eq 1 ]]
then
    echo 'root key'
    openssl rsa -noout -text  -in $key
    echo ''
    echo ''
    echo 'this csr'
    openssl req -noout -text  -in $csr
    echo ''
    echo ''
    echo 'this crt'
    openssl x509 -noout -text -in $crt
fi
