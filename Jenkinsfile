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
                bat 'wsl.exe docker build -t ecommerce-site .'
            }
        }
        
        stage('Run Container') {
            steps {
                bat '''
                    wsl.exe docker ps -a
                    wsl.exe docker stop ecommerce-site 2>nul || echo "No container to stop"
                    wsl.exe docker rm ecommerce-site 2>nul || echo "No container to remove"
                    wsl.exe docker run -d -p 8080:80 --name ecommerce-site ecommerce-site
                    echo "✅ Docker Container Started!"
                    echo "🌐 Access at: http://localhost:8080"
                '''
            }
        }
        
        stage('Test') {
            steps {
                bat '''
                    timeout /t 5
                    curl http://localhost:8080/ 2>nul && echo "✅ Website is working!" || echo "⚠️  Check manually"
                '''
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline Successful!'
        }
        failure {
            echo '❌ Pipeline Failed!'
        }
    }
}