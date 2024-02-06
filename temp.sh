DOMAIN=$1
# Check if domain is provided
if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi
NGINX_CONFIG="/etc/nginx/sites-enabled/default"

# Backup NGINX configuration file
cp "$NGINX_CONFIG" "$NGINX_CONFIG.bak"

# Add NGINX configuration for the new domain
sed -E "/^\s*server_name qwiksavings.com;/ s/;\s*$/ $DOMAIN;/" /etc/nginx/sites-enabled/default

