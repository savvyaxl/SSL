#!/bin/bash
#create CA
base_dir='/root/CA'

root_crt="${base_dir}/CA.crt"
root_csr="${base_dir}/CA.csr"
root_key="${base_dir}/CA.key"

# create a key and CSR for the CA
openssl req -nodes -newkey rsa:4096 -keyout ${root_key} -out ${root_csr} -subj "/C=BR/ST=PARANA/L=SAO JOSE DOS PINHAIS/O=SECURITY/OU=IT/CN=My CA"

# self sign the CA key
openssl x509 -req -in ${root_csr} -signkey ${root_key} -out ${root_crt} -days 3650
openssl x509 -in ${root_crt} -text -noout
