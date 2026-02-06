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
                bat 'docker build -t my-ecommerce .'
            }
        }
        
        stage('Run Container') {
            steps {
                bat '''
                    docker stop my-site || echo "No container to stop"
                    docker rm my-site || echo "No container to remove"
                    docker run -d -p 80:80 --name my-site my-ecommerce
                    echo "✅ Site is LIVE at: http://localhost"
                '''
            }
        }
    }
}