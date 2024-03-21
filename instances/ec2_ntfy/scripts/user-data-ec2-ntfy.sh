#!/bin/bash

sudo yum update;

sudo yum upgrade -y;

sudo yum install tmux -y;

sudo yum install -y docker

sudo systemctl start docker

sudo systemctl enable docker

sudo mkdir /etc/ntfy

TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)

echo "base-url: http://$PUBLIC_IP" | sudo tee /etc/ntfy/server.yml > /dev/null

echo 'upstream-base-url: "https://ntfy.sh"' | sudo tee -a /etc/ntfy/server.yml > /dev/null
            
sudo docker run -v /var/cache/ntfy:/var/cache/ntfy -v /etc/ntfy:/etc/ntfy -p 80:80 -itd binwiederhier/ntfy serve --cache-file /var/cache/ntfy/cache.db