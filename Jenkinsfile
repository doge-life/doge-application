pipeline {
    agent any

    stages {
        stage('Gradle') {
            steps {
                sh './gradlew clean check'
            }
        }
    }
}
