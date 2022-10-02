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
          bat"docker build . -t demidmgl/java-web-app:latest -t demidmgl/java-web-app:v1.0"
      }
    }
    stage('Login') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-cred-demidmgl', passwordVariable: 'pass', usernameVariable: 'user')]) {
          bat'docker login -u $user -p $pass'
        }
      }
    }
    stage('Push to Docker HUB'){
      steps {
        bat'docker push demidmgl/java-web-app:latest'
      }
    }
  }
  post {
    always {
      bat'docker logout'
    }
  }
}
