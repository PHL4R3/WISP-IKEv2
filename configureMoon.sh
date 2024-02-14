#this script is used to configure the moon (client) half of the strongswan implementation
# Check if the effective user ID is 0 (root)
if [ $(id -u) -ne 0 ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

#unzip and move to a better working dir
unzip Moon-Files
cd Moon-Files
cd moon

#move files to required spots
mv swanctl.conf /etc/swanctl/
mv moonKey.pem /etc/swanctl/private/
mv moonCert.pem /etc/swanctl/x509/
mv moonCACert.pem /etc/swanctl/x509ca/
mv moonKey.pem /etc/swanctl/x509ca/

exit 0