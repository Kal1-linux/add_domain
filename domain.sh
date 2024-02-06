#!/bin/bash

# NGINX configuration file path
NGINX_CONFIG_PATH="/etc/nginx/sites-enabled/default"

# Extract domains using grep and awk, clean up using tr, sed, and sort
domains=$(grep -E "server_name[[:space:]]" "$NGINX_CONFIG_PATH" | awk '{for (i=2; i<=NF; i++) print $i}' | tr -d ';' | tr -s ',' | sed 's/^[[:space:],]*//;s/[[:space:],]*$//' | sed '/^$/d')

# Remove unwanted characters, remove consecutive commas, and print the list of server names
cleaned_domains=$(echo "$domains" | sed 's/[^a-zA-Z0-9._-]//g' | tr -s ',' | paste -sd, - | tr -d '\n')

# Remove repeated domains
unique_domains=$(echo "$cleaned_domains" | tr ',' '\n' | sort -u | paste -sd, - | tr -d '\n')

# Print the list of unique server names
echo "Unique Server Names in $NGINX_CONFIG_PATH:"
echo "$unique_domains" > /domains.txt

