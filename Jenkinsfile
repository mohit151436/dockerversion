pipeline {
    agent any

    stages {
        stage('Deploy to EKS') {
            environment {
                AWS_DEFAULT_REGION = 'us-east-1' // Replace with your desired region
            }
            steps {
                script {
                       {
                        // Update kubeconfig
                        sh 'aws eks update-kubeconfig --name Parallels --region us-east-1'

                        // Read the deployment file
                        def deploymentFile = readFile('root/sample-deployment/deployment.yaml')

                        // Replace the image name in the deployment file
                        def updatedDeploymentFile = deploymentFile.replaceAll(/image: .*/, "image: ${params['IMAGE-Name']}:${params.TAG}")

                        // Write the updated deployment file
                        writeFile(file: 'root/sample-deployment/updated-deployment.yaml', text: updatedDeploymentFile)

                        // Apply the updated deployment
                        sh 'kubectl apply -f root/sample-deployment/updated-deployment.yaml'

                        // Expose service on a load balancer
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
