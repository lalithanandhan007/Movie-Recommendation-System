pipeline {
    agent any

    stages {

        stage('Clone Repository') {
            steps {
                echo 'Repository already checked out by Jenkins'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t movie-recommendation backend'
            }
        }

        stage('Verify Docker Image') {
            steps {
                bat 'docker images'
            }
        }

    }
}
