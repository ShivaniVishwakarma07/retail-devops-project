

pipeline {
  agent any

  environment {
    AWS_REGION = "eu-north-1"
    ECR_REPO = "416911024912.dkr.ecr.eu-north-1.amazonaws.com/retail-app"
    IMAGE_TAG = "latest"
  }

  stages {

    stage('Checkout') {
  steps {
    git branch: 'main', url: 'https://github.com/ShivaniVishwakarma07/retail-devops-project.git'
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

// pipeline {
//   agent any

//   environment {
//     AWS_REGION = "eu-north-1"
//     ECR_REPO = "416911024912.dkr.ecr.eu-north-1.amazonaws.com/retail-app"
//     IMAGE_TAG = "latest"
//   }

//   stages {

//     stage('Checkout') {
//       steps {
//         git branch: 'main', url: 'https://github.com/ShivaniVishwakarma07/retail-devops-project.git'
//       }
//     }

//     stage('Build Docker Image') {
//       steps {
//         sh 'docker build -t retail-app .'
//       }
//     }

//     stage('Tag Image') {
//       steps {
//         sh 'docker tag retail-app:latest $ECR_REPO:latest'
//       }
//     }

//     stage('Push to ECR') {
//       steps {
//         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
//           sh '''
//           aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
//           docker push $ECR_REPO:latest
//           '''
//         }
//       }
//     }

//     // 🔥 NEW STAGE (ONLY IMPORTANT ADDITION)
//     stage('Deploy to EC2') {
//       steps {
//         sshagent(['ec2-ssh']) {
//           sh '''
//           ssh -o StrictHostKeyChecking=no ec2-user@16.171.138.123 "
//           docker stop retail-app || true
//           docker rm retail-app || true
//           docker pull $ECR_REPO:latest
//           docker run -d -p 80:7000 --name retail-app $ECR_REPO:latest
//           "
//           '''
//         }
//       }
//     }

//   }
// }
