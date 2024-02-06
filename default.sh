#!/bin/bash

# NGINX configuration file path
NGINX_CONFIG_PATH="/etc/nginx/sites-enabled/default"

# Define the user-provided domain
DOMAIN=$1

# Check if domain is provided
if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Extract existing domains from the default NGINX configuration file
existing_domains=$(grep -m 1 -E "server_name[[:space:]]" "$NGINX_CONFIG_PATH" | awk '{for (i=2; i<=NF; i++) print $i}' | tr -d ';' | tr -s ',' | sed 's/^[[:space:],]*//;s/[[:space:],]*$//' | sed '/^$/d' | sed 's/[^a-zA-Z0-9._-]//g')

# Add the new domain to the existing list
updated_domains="$existing_domains $DOMAIN"

# Replace the server_name line in the NGINX configuration file
sed -i "0,/server_name[[:space:]]/s/server_name[[:space:]]$existing_domains;/server_name $updated_domains;/" "$NGINX_CONFIG_PATH"

# Reload NGINX to apply changes
systemctl reload nginx

echo "Domain $DOMAIN added to the first server_name in NGINX configuration."

