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
          bat"docker build -t demidmgl/java-web-app:latest"
      }
    }
    stage('Login') {
      steps {
        bat'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
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
