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
                sh 'docker build -t movie-recommendation ./backend'
            }
        }

        stage('Verify Docker Image') {
            steps {
                sh 'docker images'
            }
        }

    }
}
