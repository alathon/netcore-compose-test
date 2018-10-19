pipeline {
  options {
    disableConcurrentBuilds()
    timeout(time: 1, unit: 'HOURS')
    timestamps()
  }
  agent {
    kubernetes {
      label 'docker'
      defaultContainer 'jnlp'
      yamlFile 'build-pod.yaml'
    }
  }
  stages {
    stage('Build') {
      steps {
        container('docker') {
          script {
            docker.build('makewise/mono:latest', '-f ./Dockerfile.mono .')
            docker.build('netcore-iam:latest', './src/IAM')
          }
        }
      }
    }
    
    stage('Production Build and Push') {
      when {
        branch 'master'
      }
      
      steps {
        container('docker') {
          script {
            docker.build('docker-releases.danelaw.co.uk/netcore-iam:latest', '--build-arg BUILD_ENV=production ./src/IAM').push()
          }
        }
      }
    }
  }
  post {
    always {
      container('docker') {
        sh 'docker rmi docker-releases.danelaw.co.uk/netcore-iam:latest || true'
        sh 'docker rmi netcore-iam:latest || true'
      }
    }
  }
}
