#!/bin/bash

name='alexS10'
base_dir='/home/alex/CA'
ca_dir="${base_dir}/Authority"
working_dir="${base_dir}/Working"
db_dir="${base_dir}/db"
csr="${working_dir}/${name}.csr"
crt="${working_dir}/${name}.crt"
inner_crt="${ca_dir}/CA.crt"
inner_key="${ca_dir}/CA.key"

mkdir -p ${working_dir}
mkdir -p ${base_dir}/PEM
mkdir -p ${db_dir}


if [[ ! -f ${db_dir}/inter_ca.db ]]; then touch ${db_dir}/inter_ca.db; fi
if [[ ! -f ${db_dir}/index.srl ]]; then echo 04 > ${db_dir}/index.srl; fi

openssl ca -in $csr -out $crt -cert $inner_crt -keyfile $inner_key -config <(
cat <<-EOF
[ default ]
ca                      = root-ca               # CA name
dir                     = .                     # Top dir
[ ca ]
default_ca              = root_ca               # The default CA section
[ root_ca ]
new_certs_dir           = ${base_dir}/PEM       # Certificate archive
database                = ${db_dir}/inter_ca.db # Index file
serial                  = ${db_dir}/index.srl   # Serial number file
unique_subject          = no                    # Require unique subject
default_days            = 365                   # How long to certify for
default_md              = sha256                # MD to use
policy                  = any_pol               # Default naming policy
email_in_dn             = no                    # Add email to cert DN
preserve                = no                    # Keep passed DN ordering
name_opt                = ca_default            # Subject DN display options
cert_opt                = ca_default            # Certificate display options
copy_extensions         = copy                  # Copy extensions from CSR
[ any_pol ]
domainComponent         = optional
countryName             = optional
stateOrProvinceName     = optional
localityName            = optional
organizationName        = optional
organizationalUnitName  = optional
commonName              = optional
emailAddress            = optional
EOF
)

#openssl x509 -noout -text -in $crt
#openssl req -noout -text -in $csr

#openssl pkcs12 -export -inkey $key -in $crt -out /tmp/${name}.p12
#openssl pkcs12 -export -inkey $key -in $crt -out /tmp/${name}.p12 -certfile $inner_crt
#openssl pkcs12 -export -inkey $inner_key -in $inner_crt -out /tmp/${name}.ca.p12 
#openssl x509 -inform PEM -outform DER -in $crt -out $crt.crt
