# SSL
A number of sripts to create a certificate authority and sign certificates

# Setup
Run:
sh runme.sh
this will make things executable

# Create CA
./ca_create.sh
./ca_selfsign.sh

# Create SERVER certificate and sign it
./client.sh <certificate name>
./sign.sh <certificate name>

# Create CLIENT certificate and sign it
./server.sh <site FQDN>
./sign.sh <certificate name>
