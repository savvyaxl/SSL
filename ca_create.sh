#!/bin/bash
#create CA
# file name: ca_create.sh

. ./paths.ini

date_=$(date +%Y%m%d%H%M%S)
mkdir -p $root_ca_dir
if [[ -f ${root_key} ]]
then
    mkdir ${root_ca_dir}/Old.${date_}
    mv -f ${root_key} ${root_csr} ${root_crt} ${root_ca_dir}/Old.${date_}
fi

# create a key and CSR for the CA
openssl req -nodes -newkey rsa:4096 -keyout ${root_key} -out ${root_csr} -config <(
cat <<-EOF
[req]
default_bits = 4096
prompt = no
default_md = sha256
req_extensions = v3_ca
distinguished_name = dn

[ dn ]
C=BR
ST=Parana
L=Sao Jose dos Pinhais
O=Security
OU=Web Server
CN = My CA

[ v3_ca ]
# Extensions for a typical CA
subjectKeyIdentifier=hash
basicConstraints = critical,CA:true
keyUsage = cRLSign, keyCertSign
nsCertType = sslCA, emailCA
EOF
)

chmod -x ca_create.sh