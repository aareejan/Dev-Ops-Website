pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Deploy') {
            steps {
                bat '''
                    git config user.email "jenkins@example.com"
                    git config user.name "Jenkins"
                    git checkout -b gh-pages
                    git add -f index.html
                    git commit -m "Jenkins deploy"
                    git push origin gh-pages --force
                '''
            }
        }
    }
}
