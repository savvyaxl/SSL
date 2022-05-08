#!/bin/bash

name='alex2'
base_dir='/root/CA'
key="${base_dir}/${name}.key"
csr="${base_dir}/${name}.csr"
crt="${base_dir}/${name}.crt"
inner_crt="${base_dir}/CA.crt"
inner_key="${base_dir}/CA.key"


if [[ ! -f ${base_dir}/inter_ca.db ]]; then touch ${base_dir}/inter_ca1.db; fi
if [[ ! -f ${base_dir}/index.srl ]]; then echo 01 > ${base_dir}/index.srl; fi

openssl ca -in $csr -out $crt -cert $inner_crt -keyfile $inner_key -config <(
cat <<-EOF
[ default ]
ca                      = root-ca               # CA name
dir                     = .                     # Top dir
[ ca ]
default_ca              = root_ca               # The default CA section
[ root_ca ]
new_certs_dir           = .                     # Certificate archive
database                = ./inter_ca.db         # Index file
serial                  = ./index.srl           # Serial number file
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

openssl x509 -noout -text -in $crt

openssl pkcs12 -export -inkey $key -in $crt -out /tmp/${name}.p12
