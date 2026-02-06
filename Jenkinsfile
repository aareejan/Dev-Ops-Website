pipeline {
    agent any
    
    stages {
        stage('Checkout from GitHub') {
            steps {
                checkout scm
            }
        }
        
        stage('Start Docker in WSL') {
            steps {
                bat '''
                    echo Starting Docker in WSL...
                    wsl.exe sudo service docker start
                    timeout /t 10
                    wsl.exe docker --version
                '''
            }
        }
        
        stage('Build Docker Image in WSL') {
            steps {
                bat '''
                    echo Building Docker image in WSL...
                    wsl.exe docker build -t ecommerce-site:latest .
                    echo Image built successfully!
                '''
            }
        }
        
        stage('Run Container on Port 9090') {
            steps {
                bat '''
                    echo Running Docker container on port 9090...
                    wsl.exe docker stop ecommerce-container 2>/dev/null || echo "No container to stop"
                    wsl.exe docker rm ecommerce-container 2>/dev/null || echo "No container to remove"
                    wsl.exe docker run -d -p 9090:80 --name ecommerce-container ecommerce-site:latest
                    
                    echo ========================================
                    echo ✅ DOCKER CONTAINER DEPLOYED!
                    echo 🌐 URL: http://localhost:9090
                    echo 📍 Port: 9090
                    echo 🐳 Container: ecommerce-container
                    echo ========================================
                '''
            }
        }
        
        stage('Verify Deployment') {
            steps {
                bat '''
                    echo Verifying deployment...
                    timeout /t 5
                    curl http://localhost:9090/ 2>nul && (
                        echo ✅ WEBSITE IS ACCESSIBLE!
                    ) || (
                        echo ⚠️  Manual check needed: Open browser to http://localhost:9090
                    )
                '''
            }
        }
    }
}