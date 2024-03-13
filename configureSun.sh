#this script configures the Sun (server) side of the strongswan implementation
# Check if the effective user ID is 0 (root)
if [ $(id -u) -ne 0 ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

#unzip and move to a better working dir
unzip Sun-Files
cd Sun

#move files to required spots
cp swanctl.conf /etc/swanctl/
cp sunKey.pem /etc/swanctl/private/
cp sunReq.pem /etc/swanctl/private/
cp sunCert.pem /etc/swanctl/x509/
cp sunCACert.pem /etc/swanctl/x509ca/
cp sunKey.pem /etc/swanctl/x509ca/

#load creds and conns
swanctl --load-creds
swanctl --load-conns
exit 0
