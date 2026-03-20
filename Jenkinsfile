pipeline {
  agent any

  environment {
    AWS_REGION = "ap-south-1"
    ECR_REPO = "416911024912.dkr.ecr.eu-north-1.amazonaws.com/retail-app"
    IMAGE_TAG = "latest"
  }

  stages {

    stage('Checkout') {
      steps {
        git 'https://github.com/ShivaniVishwakarma07/retail-devops-project.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t retail-app .'
      }
    }

    stage('Tag Image') {
      steps {
        sh 'docker tag retail-app:latest $ECR_REPO:latest'
      }
    }

    stage('Push to ECR') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
          sh '''
          aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
          docker push $ECR_REPO:latest
          '''
        }
      }
    }

  }
}