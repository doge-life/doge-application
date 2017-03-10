#!groovy

def getAMIFromPackerManifest() {
    def workspace = pwd()
    def manifest = new File("${workspace}/packer/manifest.json")
    def json = new groovy.json.JsonSlurper().parseText(manifest.text)
    def ami_info = json.builds.first().artifact_id.split(':')
    ami_info[1]
}

pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        TF_VAR_doge_private_key = credentials('doge-private-key')
    }
    stages {
        stage('Unit Tests') {
            steps {
                sh './gradlew test'
            }
        }
        stage('Static Analysis') {
            steps {
                sh './gradlew pmdMain'
                archiveArtifacts artifacts: '**/build/reports/**', fingerprint: true
            }
        }
        stage('Build Application') {
            steps {
                sh './gradlew build'
            }
        }
        stage('Build and Verify Images') {
            steps {
                sh './packer/build'
            }
        }
        stage('Deploy to Dev') {
            when {
                branch 'master'
            }
            steps {
                sh "./terraform/providers/aws/us_east_1_dev/plan ${getAMIFromPackerManifest()}"
                sh "./terraform/providers/aws/us_east_1_dev/apply ${getAMIFromPackerManifest()}"
                archiveArtifacts artifacts: "**/terraform.tfstate"
            }
        }
    }
}
