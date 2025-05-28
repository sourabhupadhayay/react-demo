stage('Run Certbot') {
  steps {
    writeFile file: 'certbot-setup.sh', text: '''#!/bin/bash
DOMAIN="app.4xexch.com"
EMAIL="sourbhupadhayay@gmail.com"

sudo apt update
sudo apt install -y certbot

# Stop any service using port 80 to avoid conflict
sudo fuser -k 80/tcp || true

sudo certbot certonly --standalone -d $DOMAIN --agree-tos --email $EMAIL --non-interactive
'''
    sh 'chmod +x certbot-setup.sh'
    sh "sed -i 's/\r//' certbot-setup.sh"
    sh './certbot-setup.sh'
  }
}

