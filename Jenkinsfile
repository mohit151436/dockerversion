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

        stage('Clean up') {
            steps {
                sh "docker rmi ${params['IMAGE-Name']}:${params.TAG}"
            }
        }
    }

}
