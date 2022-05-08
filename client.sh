#!/bin/bash

name='alex2'
base_dir='/root/CA'
key="${base_dir}/${name}.key"
csr="${base_dir}/${name}.csr"
crt="${base_dir}/${name}.crt"
#for encrypted key use -sha256 otherwise, nodes
openssl req -new -nodes -out $csr -keyout $key -config <(
cat <<-EOF
[req]
default_bits = 2048
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
nsCertType = client, email
nsComment = "OpenSSL Generated Client Certificate"
subjectKeyIdentifier = hash
keyUsage = critical, nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, emailProtection
EOF
)
openssl rsa -noout -text -in $key
openssl req -noout -text -in $csr
