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
                withCredentials([usernamePassword(credentialsId: '1015f339-4779-4073-a126-91881d50cf35', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
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

    post {
        always {
            emailext (
                subject: "Pipeline ${currentBuild.result}: ${params['IMAGE-Name']}:${params.TAG}",
                body: "Pipeline ${currentBuild.result}: ${params['IMAGE-Name']}:${params.TAG}",
                to: "recipient1@example.com, recipient2@example.com, recipient3@example.com"
            )
        }
    }

    triggers {
        scm('*')
    }
}
