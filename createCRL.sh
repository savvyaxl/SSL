#!/bin/bash

export name
. ./paths.ini

mkdir -p ${PEM_dir}
mkdir -p ${DB_dir}

date_=$(date +%Y%m%d)
if [[ ! -f ${DB} ]]; then touch ${DB}; fi
if [[ ! -f ${index} ]]; then echo ${date_}0001 > ${index}; fi
if [[ ! -f ${crlnumber} ]]; then echo 1000 > ${crlnumber}; fi


openssl ca -gencrl -keyfile ${root_key} -cert ${root_crt} -out ${root_crl} -config <(
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
#copy_extensions         = copy                  # Copy extensions from CSR
x509_extensions         = mySubCA
crlnumber               = ${crlnumber}
default_crl_days        = 730

[ mySubCA ]
basicConstraints = CA:true
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always
keyUsage = digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth
crlDistributionPoints = URI:http://example.com/root.crl

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

openssl crl -inform PEM -in ${root_crl} -outform DER -out ${root_crl_der}
