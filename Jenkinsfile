pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Afreed7411/ci-cd-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build --no-cache -t vite-app .'
            }
        }

        stage('Deploy Application') {
            steps {
                bat '''
                docker stop vite-container || echo Container not running
                docker rm vite-container || echo Container not found
                docker run -d -p 8081:80 --name vite-container vite-app
                '''
            }
        }

        stage('Test Application') {
            steps {
                bat '''
                echo Waiting for app to start...
                timeout /t 5 /nobreak > nul

                curl -f http://localhost:8081 || exit /b 1
                '''
            }
        }
    }

    post {
        success {
            echo 'CI/CD Pipeline executed successfully '
        }
        failure {
            echo 'CI/CD Pipeline failed '
        }
    }
}
