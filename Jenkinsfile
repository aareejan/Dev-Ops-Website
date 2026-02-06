pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build image
                    docker.build('ecommerce-site:latest')
                }
            }
        }
        
        stage('Run Container') {
            steps {
                script {
                    // Stop old container if running
                    sh 'docker stop ecommerce-container || true'
                    sh 'docker rm ecommerce-container || true'
                    
                    // Run new container
                    sh 'docker run -d -p 8080:80 --name ecommerce-container ecommerce-site:latest'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    // Check if site is accessible
                    sh 'sleep 5 && curl -f http://localhost:9080/ || exit 1'
                }
            }
        }
    }
}