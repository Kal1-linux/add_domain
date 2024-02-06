# SSL AUTO creation script with certbot and nginx to add new domain in one click 

# Prerequisite : in route 53 add Aliases 
# For example : add this "A *.yourdomain.com" instead this "A site.xyz.com" 

#commands to install certbot nginx 

#→Installation:

sudo apt update

sudo apt -y install nginx certbot python3-certbot-nginx 

sudo systemctl enable nginx

sudo systemctl start nginx





# to run this script there are two files 



# just for adding domain on currently added domain

sudo ./add_dom.sh subdomian.yourdomain.com

# to add new domain with ssl auto done with your port address 

sudo ./add_domain.sh subdomain.yourdomain.com

