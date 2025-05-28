stage('Run Certbot') {
  steps {
    writeFile file: 'certbot-setup.sh', text: '''#!/bin/bash
DOMAIN="app.4xexch.com"
EMAIL="sourbhupadhayay@gmail.com"

sudo apt update
sudo apt install -y certbot

# Stop any service using port 80 to let certbot bind
sudo fuser -k 80/tcp || true

sudo certbot certonly --standalone -d $DOMAIN --agree-tos --email $EMAIL --non-interactive
'''
    sh 'sudo apt update && sudo apt install -y dos2unix'
    sh 'chmod +x certbot-setup.sh'
    sh 'dos2unix certbot-setup.sh'
    sh './certbot-setup.sh'
  }
}

