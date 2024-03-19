#this script is used to configure the moon (client) half of the strongswan implementation
# Check if the effective user ID is 0 (root)
if [ $(id -u) -ne 0 ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

#unzip and move to a better working dir
unzip Moon-Files.zip
cd Moon

#move files to required spots
cp swanctl.conf /etc/swanctl/
cp moonKey.pem /etc/swanctl/private/
cp moonCert.pem /etc/swanctl/x509/
cp sunCACert.pem /etc/swanctl/x509ca/
cp moonkey.pem /etc/swanctl/x509ca/

#load creds and conns
systemctl enable strongswan
systemctl start strongswan

exit 0