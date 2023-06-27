pipeline {
    agent any

    stages {
        stage('Deploy to EKS') {
            environment {
                AWS_DEFAULT_REGION = 'us-east-1' // Replace with your desired region
            }
            steps {
                script {
                    withCredentials([
                        awsCredentials(credentialsId: '3f3050f8-f846-443a-b79b-8495e4fa327b')
                    ]) {
                        sh 'aws eks update-kubeconfig --name Parallels --region us-east-1'
                    }
                }
            }
        }

        stage('Clean up') {
            steps {
                sh "docker rmi ${params['IMAGE-Name']}:${params.TAG}"
            }
        }
    }
}
