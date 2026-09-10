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

# 1. Generate the elliptic curve private key first
openssl ecparam -name prime256v1 -genkey -noout -out ${key}

# 2. Generate the CSR using that key and your configuration block
openssl req -new -key ${key} -out ${csr} -config <(
cat <<-EOF
[req]
prompt = no
default_md = sha256
req_extensions = client_ext
distinguished_name = dn
[ dn ]
C=BR
ST=Parana
L=Sao Jose dos Pinhais
O=Security
OU=Web Client
CN = $name
[ client_ext ]
nsCertType = client
nsComment = "OpenSSL Generated ECDSA Client Certificate"
subjectKeyIdentifier = hash
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth
EOF
)
