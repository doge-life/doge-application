#!groovy

def getAMIFromPackerManifest() {
    def workspace = pwd()
    def manifest = new File("${workspace}/packer/manifest.json")
    def json = new groovy.json.JsonSlurper().parseText(manifest.text)
    json.builds.first().artifact_id
}

pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = "AKIAJIAYKGAD7SZSF6FQ"
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
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
        stage('Build and verify images') {
            steps {
                sh './packer/verify'
            }
        }
        stage('Terraform') {
            steps {
                echo "${getAMIFromPackerManifest()}"
            }
        }
    }
}
