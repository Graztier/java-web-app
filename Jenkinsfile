pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred-demidmgl')
  }
  stages {
    stage('Scan') {
      steps {
        withSonarQubeEnv(installationName: 'sq1') { 
          bat'mvn clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
        }
      }
    }
    stage('Build + tag') {
      steps {
          bat"docker build ."
      }
    }
    stage('Login') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-cred-demidmgl') {
            dockImage = docker.build -t java-web-app:latest .'
            dockImage.push()
          }
        }
      }
    }
  }
  post {
    always {
      bat'docker logout'
    }
  }
}
