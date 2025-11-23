#!/bin/bash
apt update -y
apt install -y nginx
systemctl start nginx
systemctl enable nginx

# Create the HTML page with hostname
cat <<EOF > /var/www/html/index.nginx-debian.html
<html>
  <head><title>Welcome to NGINX on Ubuntu EC2</title></head>
  <body>
    <h1>Deployed via EC2 User Data</h1>
    <p>Instance Hostname: $(hostname)</p>
  </body>
</html>
EOF
