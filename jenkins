pipeline {
    agent any
    
    parameters {
        string(name: 'TAG', defaultValue: 'latest', description: 'Docker image tag')
    }
    
    stages {
        stage('Build') {
            steps {
                sh "docker build -t myimage:${params.TAG} ."
                
            }
        }
    }
}
