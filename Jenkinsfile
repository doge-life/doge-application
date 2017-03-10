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
            agent { label 'master' }
            steps {
                sh './gradlew test'
                stash "DOGE-66-12"
            }
        }
        stage('Static Analysis') {
            agent { label 'master' }
            steps {
                unstash "DOGE-66-12"
                sh './gradlew pmdMain'
                archiveArtifacts artifacts: '**/build/reports/**', fingerprint: true
                stash "DOGE-66-12"
            }
        }
        stage('Build Application') {
            agent { label 'master' }
            steps {
                unstash "DOGE-66-12"
                sh './gradlew build'
                stash "DOGE-66-12"
            }
        }
        stage('Build and Verify Images') {
            agent { label 'master' }
            environment {
                AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }
            steps {
                unstash "DOGE-66-12"
                sh './packer/build'
                stash "DOGE-66-12"
            }
        }
        stage('Deploy to Dev') {
            agent { label 'master' }
            environment {
                AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
            }   
            steps {
                unstash "DOGE-66-12"
                sh "./terraform/deploy.sh dev ${getAMIFromPackerManifest()}"
                stash "DOGE-66-12"
            }
        }
        stage('Functional tests against dev') {
            agent { label 'master' }
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
            agent { label 'master' }
            when { branch 'master' }
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
