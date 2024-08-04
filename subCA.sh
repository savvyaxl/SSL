#!/bin/bash

if [[ -n $1 ]]
then
    name=$1
else
    echo Please set the certificate name
    exit 1
fi

export name
. ./paths.ini
mkdir -p ${working_dir}

#for encrypted key use -sha256
openssl req -new -nodes -out $csr -keyout $key -config <(
cat <<-EOF
[req]
default_bits = 4096
prompt = no
default_md = sha384
req_extensions = req_ext
distinguished_name = dn

[ dn ]
dc=nfs
dc=info
CN = $name

[ req_ext ]
basicConstraints = critical,CA:true
keyUsage = digitalSignature,cRLSign,keyCertSign

EOF
)
