pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Test HTML') {
            steps {
                bat '''
                    echo "✅ Jenkins CI/CD Pipeline Working!"
                    echo "📁 Files:"
                    dir
                    echo "🌐 Your e-commerce site is ready."
                    echo "📄 HTML preview:"
                    type index.html | findstr /C:"<title" /C:"<!DOCTYPE"
                '''
            }
        }
        
        stage('Create Artifact') {
            steps {
                bat 'mkdir deploy 2>nul && copy index.html deploy\\'
                archiveArtifacts artifacts: 'deploy/**', fingerprint: true
            }
        }
        
        stage('Deploy Simulated') {
            steps {
                bat '''
                    echo "🚀 Simulated Deployment Complete!"
                    echo "📊 Next steps after WSL2:"
                    echo "1. wsl.exe docker build -t ecommerce ."
                    echo "2. wsl.exe docker run -d -p 8080:80 ecommerce"
                    echo "3. Access: http://localhost:8080"
                '''
            }
        }
    }
}