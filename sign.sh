#!/bin/bash

#export name='brew.savvyaxl.com.br'
. ./paths.ini

mkdir -p ${PEM_dir}
mkdir -p ${DB_dir}

if [[ ! -f ${DB} ]]; then touch ${DB}; fi
if [[ ! -f ${index} ]]; then echo 04 > ${index}; fi


openssl ca -in ${csr} -out ${crt} -keyfile ${root_key} -cert ${root_crt} -config <(
cat <<-EOF
[ default ]
ca                      = root-ca               # CA name
[ ca ]
default_ca              = root_ca               # The default CA section
[ root_ca ]
new_certs_dir           = ${PEM_dir}            # Certificate archive
database                = ${DB}                 # Index file
serial                  = ${index}              # Serial number file
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
