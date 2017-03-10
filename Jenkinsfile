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

    stages {
        stage('Unit Tests') {
            agent any
            steps {
                sh './gradlew test'
            }
        }
        stage('Static Analysis') {
            agent any
            steps {
                sh './gradlew pmdMain'
                archiveArtifacts artifacts: '**/build/reports/**', fingerprint: true
            }
        }
        stage('Build Application') {
            agent any
            steps {
                sh './gradlew build'
            }
        }
        stage('Build and Verify Images') {
            agent any
            environment {
                AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }
            steps {
                sh './packer/build'
            }
        }
        stage('Deploy to Dev') {
            agent any
            environment {
                AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }   
            steps {
                sh "./terraform/deploy.sh dev ${getAMIFromPackerManifest()}"
            }
        }
        stage('Functional tests against dev') {
            agent any
            steps {
                echo 'Functional tests running...and done!'
            }
        }
        stage('Wait for user to deploy to prod') {
            steps {
                input "Deploy this build to production?"
            }
        }
        stage('Deploy to Prod') {
            agent any
            environment {
                AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }
            steps {
                sh "./terraform/deploy.sh prod ${getAMIFromPackerManifest()}"
            }
        }
    }
}
