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
                        awsCredentials(credentialsId: 'ea0c250c-ad8d-4bb9-8c71-9a89e516ab52', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        sh 'aws eks update-kubeconfig --name Parallels --region us-east-1'
                        def deploymentFile = readFile 'root/sample-deployment/deployment.yaml'
                        def updatedDeploymentFile = deploymentFile.replaceAll(/image: .*/, "image: ${params['IMAGE-Name']}:${params.TAG}")
                        writeFile file: 'root/sample-deployment/updated-deployment.yaml', text: updatedDeploymentFile
                        sh 'kubectl apply -f root/sample-deployment/updated-deployment.yaml'
                        sh "kubectl expose deployment my-deployment --port=80 --target-port=8080 --type=LoadBalancer"
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
