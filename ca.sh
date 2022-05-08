#create CA
#openssl genrsa -out CA.key 4096

# create a key and CSR for the CA
openssl req -nodes -newkey rsa:4096 -keyout CA.key -out CA.csr -subj "/C=BR/ST=PARANA/L=SAO JOSE DOS PINHAIS/O=SECURITY/OU=IT/CN=My CA"

# self sign the CA key
openssl x509 -req -in CA.csr -signkey CA.key -out CA.crt -days 3650
openssl x509 -in CA.crt -text -noout
