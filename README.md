# SSL
A number of sripts to create a certificate authority and sign certificates

# Setup
Run:<br>
sh runme.sh<br>
this will make things executable

# Important
Make changes to the scripts with your own information<br>
Change the [ dn ] section.
<b>Change:</b><br>
ca_create.sh<br>
client.sh<br>
server.sh<br>
They will create the certificate sighing request

# Create CA
./ca_create.sh <br>
./ca_selfsign.sh

# Create SERVER certificate and sign it
./server.sh &#60;site FQDN&#62; <br>
./sign.sh &#60;site FQDN&#62;

# Create CLIENT certificate and sign it
./client.sh &#60;certificate name&#62; <br>
./sign.sh &#60;certificate name&#62;
