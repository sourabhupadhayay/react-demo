pipeline {
  agent any
  environment {
    DOCKER_IMAGE = "react-nginx"
    DOCKER_TAG = "latest"
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
    stage('Run Container') {
      steps {
        sh 'docker stop react-nginx || true && docker rm react-nginx || true'
        sh 'docker run -d --name react-nginx -p 80:80 $DOCKER_IMAGE:$DOCKER_TAG'
      }
    }
    stage('Update DNS') {
      steps {
        sh './update-dns.sh'
      }
    }
    stage('Verify App') {
      steps {
        sh 'curl -I http://app.4xexch.com'
      }
    }
  }
}

