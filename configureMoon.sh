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
cp moonKey.pem /etc/swanctl/x509ca/

#start the service
sudo /usr/libexec/ipsec/charon
#load creds and conns
swanctl --load-creds
swanctl --load-conns

exit 0