#!/bin/bash
#sudo pkill nginx
# Define variables
DOMAIN=$1

# Check if domain is provided
if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Prompt user for the port
read -p "Enter the port for proxy_pass (default is 5173): " PORT
PORT=${PORT:-5173}

# Set the path to your Nginx configuration file
NGINX_CONFIG_PATH="/etc/nginx/sites-enabled/default"

# Create a backup of the original configuration file
cp "$NGINX_CONFIG_PATH" "$NGINX_CONFIG_PATH.bak"

# Add the new domain to the first occurrence of the server_name directive
sed -i "0,/server_name/{s/server_name \(.*\);/server_name \1 $DOMAIN;/}" "$NGINX_CONFIG_PATH"
# Create a symbolic link to enable the site
#ln -s /etc/nginx/sites-enabled/$DOMAIN /etc/nginx/sites-available/

# Reload NGINX to apply changes
#systemctl stop nginx
#systemctl disable nginx
# Run Certbot to obtain SSL certificate
#sudo certbot certonly --standalone -d $DOMAIN
#sudo certbot certonly --nginx --force-renewal --non-interactive -d $DOMAIN
#sudo certbot --nginx -d $DOMAIN
#systemctl restart nginx
#./certbot_expect_script
#./cert_new



# Assuming $DOMAIN contains the new domain name
echo "$(cat /domain.txt),$DOMAIN" | sed 's/^,//' >> /domain.txt
#echo "$(cat /domains.txt),$DOMAIN" | sed 's/^,//' > /domains.txt

./domain.sh


./add_ssl.sh
#systemctl enable nginx
#pkill nginx
systemctl restart nginx

