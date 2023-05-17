pipeline {
    agent any
    
    parameters {
        choice(
            choices: ['image1', 'image2', 'image3'],
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
        
        stage('Push') {
            steps {
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
