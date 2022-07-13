#Install Apache;
yum install --quite -y httpd httpd-devel
#Copy configuration file:
cp httpd.conf /etc/httpd/conf/httpd.conf
cp httpd-vhosts /etc/httpd/conf/httpd-vhosts.conf
# Start Apache and conf to start at boot
service httpd start
chkonfig httpd on