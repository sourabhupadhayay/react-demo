stage('Run Certbot') {
  steps {
    writeFile file: 'certbot.sh', text: '''#!/bin/bash
DOMAIN="app.4xexch.com"
EMAIL="sourbhupadhayay@gmail.com"

sudo apt update
sudo apt install -y certbot

sudo certbot certonly --standalone -d $DOMAIN --agree-tos --email $EMAIL --non-interactive
'''
    sh 'chmod +x certbot.sh'
    sh './certbot.sh'
  }
}

