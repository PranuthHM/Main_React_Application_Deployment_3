pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "pranuthhm"
        DEV_REPO = "dev"
        PROD_REPO = "prod"
        IMAGE_NAME = "main_react_application_deployment_3"
        SSH_USER = "ubuntu"
        EC2_HOST = "13.201.58.201"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def current_repo = (env.BRANCH_NAME == 'dev') ? env.DEV_REPO : env.PROD_REPO
                    def current_tag = "${env.BRANCH_NAME}-${BUILD_NUMBER}"
                    sh "docker build -t ${DOCKERHUB_USER}/${current_repo}:${current_tag} ."
                    sh "docker tag ${DOCKERHUB_USER}/${current_repo}:${current_tag} ${DOCKERHUB_USER}/${current_repo}:latest"
                }
            }
        }
        
        stage('Login and Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    
                    script {
                        def current_repo = (env.BRANCH_NAME == 'dev') ? env.DEV_REPO : env.PROD_REPO
                        def current_tag = "${env.BRANCH_NAME}-${BUILD_NUMBER}"
                        sh "docker push ${DOCKERHUB_USER}/${current_repo}:${current_tag}"
                        sh "docker push ${DOCKERHUB_USER}/${current_repo}:latest"
                    }
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        def current_repo = (env.BRANCH_NAME == 'dev') ? env.DEV_REPO : env.PROD_REPO
                        def current_tag = "${env.BRANCH_NAME}-${BUILD_NUMBER}"

                        sshagent(['ec2-ssh-credentials']) {
                            sh """
                            ssh -o StrictHostKeyChecking=no ${SSH_USER}@${EC2_HOST} "docker login -u ${DOCKERHUB_USER} -p ${DOCKER_PASS}; docker pull ${DOCKERHUB_USER}/${current_repo}:${current_tag}; docker stop react-app-container || true; docker rm react-app-container || true; docker run -d --name react-app-container -p 80:80 ${DOCKERHUB_USER}/${current_repo}:${current_tag}"
                            """
                        }
                    }
                }
            }
        }
    }
}
