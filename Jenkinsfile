pipeline {
    agent any
    
    parameters {
        string(
            defaultValue: 'harbor.sp.run/sptst/',
            description: 'Select a Docker image:',
            name: 'IMAGE'
        )
        string(
            defaultValue: 'latest',
            description: 'Docker image tag',
            name: 'TAG'
        )
    }
    
    stages {
        stage('Build') {
            steps {
                sh "docker build -t ${params.IMAGE}:${params.TAG} ."
            }
        }
        
        stage('Login and Push') {
            steps {
   
                sh "docker login harbor.sp.run/sptst -u mohit -p bW9oaXQK"
                sh "docker push ${params.IMAGE}:${params.TAG}"
            }
        }
        
        stage('Clean up') {
            steps {
                sh "docker rmi ${params.IMAGE}:${params.TAG}"
            }
        }
    }
}
