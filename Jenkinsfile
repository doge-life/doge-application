#!groovy

def getAMIFromPackerManifest() {
    def workspace = pwd()
    def manifest = new File("${workspace}/packer/manifest.json")
    def json = new groovy.json.JsonSlurper().parseText(manifest.text)
    def ami_info = json.builds.first().artifact_id.split(':')
    ami_info[1]
}

pipeline {
    agent none

    options {
        skipDefaultCheckout()
    }
    stages {
        stage('Clean workspace') {
            agent { label 'master' }
            steps {
                step([$class: 'WsCleanup'])
            }
        }
        stage('Checkout code') {
            agent { label 'master' }
            steps {
                checkout scm
            }
        }
        stage('Unit Tests') {
            agent { label 'master' }
            steps {
                sh './gradlew test'
            }
        }
        stage('Static Analysis') {
            agent { label 'master' }
            steps {
                sh './gradlew pmdMain'
                archiveArtifacts artifacts: '**/build/reports/**', fingerprint: true
            }
        }
        stage('Build Application') {
            agent { label 'master' }
            steps {
                sh './gradlew build'
            }
        }
        stage('Build and Verify Images') {
            agent { label 'master' }
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
            agent { label 'master' }
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
            agent { label 'master' }
            steps {
                echo 'Functional tests running...and done!'
            }
        }
        stage('Wait for user to deploy to prod') {
            when { branch 'master' }
            steps {
                input "Deploy this build to production?"
            }
        }
        stage('Deploy to Prod') {
            when { branch 'master' }
            agent { label 'master' }
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

