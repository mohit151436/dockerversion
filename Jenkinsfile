pipeline {
    agent any

    parameters {
        string(
            defaultValue: 'harbor.sp.run/sptst/',
            description: 'Select a Docker image:',
            name: 'IMAGE-Name'
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
                sh "docker build -t ${params['IMAGE-Name']}:${params.TAG} ."
            }
        }

        stage('Login and Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'da0ec85a-9f23-4167-9ec2-b8f02976caf6', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh "docker login -u $USERNAME -p $PASSWORD harbor.sp.run"
                    sh "docker push ${params['IMAGE-Name']}:${params.TAG}"
                }
            }
        }

        stage('Deploy to EKS') {
            environment {
                AWS_DEFAULT_REGION = 'us-east-1' // Replace with your desired region
            }
            steps {
                script {
                    // Configure AWS credentials
                    withCredentials([
                        awsCredentials(credentialsId: '3f3050f8-f846-443a-b79b-8495e4fa327b', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        // Update kubeconfig
                        sh 'aws eks update-kubeconfig --name Parallels --region us-east-1'

                        // Read the deployment file
                        def deploymentFile = readFile 'root/sample-deployment/deployment.yaml'

                        // Replace the image name in the deployment file
                        def updatedDeploymentFile = deploymentFile.replaceAll(/image: .*/, "image: ${params['IMAGE-Name']}:${params.TAG}")

                        // Write the updated deployment file
                        writeFile file: 'root/sample-deployment/updated-deployment.yaml', text: updatedDeploymentFile

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
