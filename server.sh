#!/bin/bash

name='savvyaxl.com.br'
base_dir='/root/CA'
key="${base_dir}/${name}.key"
csr="${base_dir}/${name}.csr"
crt="${base_dir}/${name}.crt"

#for encrypted key use -sha256
openssl req -new -nodes -out $csr -keyout $key -config <(
cat <<-EOF
[req]
default_bits = 2048
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
DNS.1 = $name
DNS.2 = www.${name}
DNS.3 = home.${name}
DNS.4 = brew.${name}

EOF
)

