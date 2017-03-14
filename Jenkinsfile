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

    stages {
        stage('Build Application') {
            steps {
                sh './gradlew clean build'
                archiveArtifacts artifacts: '**/build/reports/**', fingerprint: true
            }
        }
        stage('Build and Verify Images') {
            environment {
                AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }
            steps {
                sh './packer/build'
            }
        }
        stage('Deploy to Dev') {
            when { branch 'master' }
            environment {
                AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }   
            steps {
                withCredentials([file(credentialsId: 'doge-private-key-file', variable: 'TF_VAR_doge_private_key_file')]) {
                    sh "./terraform/deploy.sh dev ${getAMIFromPackerManifest()}"
                    archiveArtifacts artifacts: "**/terraform.tfstate"
                }
            }
        }
        stage('Functional tests against dev') {
            when { branch 'master' }
            steps {
                echo 'Functional tests running...and done!'
            }
        }
        stage('Deploy to Prod') {
            when { branch 'master' }
            environment {
                AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }
            steps {
                withCredentials([file(credentialsId: 'doge-private-key-file', variable: 'TF_VAR_doge_private_key_file')]) {
                    sh "./terraform/deploy.sh prod ${getAMIFromPackerManifest()}"
                    archiveArtifacts artifacts: "**/terraform.tfstate"
                }
            }
        }
    }
}

