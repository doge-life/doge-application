#!groovy

node {
    checkout scm

    dockerImage = docker.image('gradle')

    withCredentials([
        usernamePassword(usernameVariable: 'MAVEN_NEXUS_USR', passwordVariable: 'MAVEN_NEXUS_PSW', credentialsId: 'nexus-credentials'),
        ]) {
            
        stage('Unit Test') {
            dockerImage.inside() {
                sh './gradlew clean test'
            }
        }
        stage('Assemble') {
            dockerImage.inside() {
                sh './gradlew clean assemble'
            }
        }
        stage('Build Docker Image') {
            sh 'docker build -t doge-life/doge-application .' 
        }
        stage('Publish to Registry') {
            sh "scripts/publishToRegistry.sh ${MAVEN_NEXUS_USR} ${MAVEN_NEXUS_PSW} ${NEXUS_REGISTRY_URL}"
        }
        if (env.BRANCH_NAME == 'master') {
          stage('Update latest tag') {
              sh "scripts/publishToRegistry.sh ${MAVEN_NEXUS_USR} ${MAVEN_NEXUS_PSW} ${NEXUS_REGISTRY_URL} latest"
          } 
        }
      }
}

