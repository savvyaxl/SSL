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
default_bits = 3072
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C=BR
ST=Parana
L=Sao Jose dos Pinhais
O=Security
OU=Web Server
CN = $name

[ req_ext ]
subjectAltName = @alt_names
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth

[ alt_names ]
DNS.0 = $name
#DNS.1 = *.$name

EOF
)

