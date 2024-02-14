#this script configures the Sun (server) side of the strongswan implementation
# Check if the effective user ID is 0 (root)
if [ $(id -u) -ne 0 ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

#unzip and move to a better working dir
unzip Sun-Files
cd Sun-Files
cd Sun

#move files to required spots
mv swanctl.conf /etc/swanctl/
mv sunKey.pem /etc/swanctl/private/
mv sunReq.pem /etc/swanctl/private/
mv sunCert.pem /etc/swanctl/x509/
mv sunCACert.pem /etc/swanctl/x509ca/
mv sunKey.pem /etc/swanctl/x509ca/

exit 0
