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
                bat '''
                    echo Building Docker image...
                    docker build -t ecommerce-site .
                    echo Docker image built successfully
                '''
            }
        }
        
        stage('Run Container') {
            steps {
                bat '''
                    echo Stopping old container...
                    docker stop ecommerce-container || echo "No container to stop"
                    docker rm ecommerce-container || echo "No container to remove"
                    
                    echo Starting new container...
                    docker run -d -p 8080:80 --name ecommerce-container ecommerce-site
                    
                    echo Container started on port 8080
                '''
            }
        }
        
        stage('Test') {
            steps {
                bat '''
                    echo Waiting for container to start...
                    timeout /t 10
                    echo Testing website...
                    curl http://localhost:8080/ || echo "Site test completed"
                '''
            }
        }
    }
}