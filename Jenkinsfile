pipeline {
  agent any
  environment {
    DOCKER_IMAGE = "react-nginx"
    DOCKER_TAG = "latest"
    DOMAIN = "app.4xexch.com"
    EMAIL = "sourbhupadhayay@gmail.com"
  }
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/sourabhupadhayay/react-demo.git'
      }
    }

    stage('Build React') {
      steps {
        dir('react-demo') {
          sh 'npm install'
          sh 'npm run build'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
      }
    }

    stage('Run Certbot') {
      steps {
        writeFile file: 'certbot-setup.sh', text: '''#!/bin/bash
DOMAIN="app.4xexch.com"
EMAIL="sourbhupadhayay@gmail.com"

sudo apt update
sudo apt install -y certbot

# Stop any service using port 80 (to avoid conflicts with certbot)
sudo fuser -k 80/tcp || true

sudo certbot certonly --standalone -d $DOMAIN --agree-tos --email $EMAIL --non-interactive
'''
        sh 'chmod +x certbot-setup.sh'
        sh 'dos2unix certbot-setup.sh'
        sh './certbot-setup.sh'
      }
    }

    stage('Run HTTPS Container') {
      steps {
        sh '''
          docker stop react-nginx || true
          docker rm react-nginx || true

          docker run -d --name react-nginx -p 80:80 -p 443:443 \
            -v /etc/letsencrypt/live/$DOMAIN/fullchain.pem:/etc/nginx/ssl/fullchain.pem:ro \
            -v /etc/letsencrypt/live/$DOMAIN/privkey.pem:/etc/nginx/ssl/privkey.pem:ro \
            $DOCKER_IMAGE:$DOCKER_TAG
        '''
      }
    }

    stage('Update DNS') {
      steps {
        sh './update-dns.sh'
      }
    }

    stage('Verify HTTPS') {
      steps {
        sh 'curl -I https://$DOMAIN --resolve $DOMAIN:443:127.0.0.1 --insecure'
      }
    }
  }
}
