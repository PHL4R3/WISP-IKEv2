#this script configures the Sun (server) side of the strongswan implementation
# Check if the effective user ID is 0 (root)
if [ $(id -u) -ne 0 ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

#unzip and move to a better working dir
unzip Sun.zip
cd Sun

#move files to required spots
cp swanctl.conf /etc/swanctl/
cp sunKey.pem /etc/swanctl/private/
cp sunCert.pem /etc/swanctl/x509/
cp strongswanCert.pem /etc/swanctl/x509ca/
cp strongswan.conf /etc/

#load creds and conns
systemctl enable strongswan
systemctl start strongswan

exit 0
