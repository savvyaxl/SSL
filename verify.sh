openssl rsa -noout -text  -in ${root_key}
openssl req -noout -text  -in ${root_csr}
openssl x509 -text -noout -in ${root_crt}


openssl rsa -noout -text -in $key
openssl req -noout -text -in $csr
openssl x509 -noout -text -in $crt

#openssl pkcs12 -export -inkey $key -in $crt -certfile ${root_crt} -out /tmp/${name}.p12
