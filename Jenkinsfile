pipeline {
    agent any

    environment {
        GIT_URL = 'https://github.com/ogunmehmetsalih/nodejs_ex_pip.git'
        GIT_BRANCH = 'master'
        GIT_CREDENTIALS_ID = ''  // Public repo olduğu için boş kalabilir
        DOCKER_IMAGE = 'msalihogun/nodejs_ex_pip'
        DOCKER_TAG = 'latest'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
        EMAIL_RECIPIENTS = 'msalihogun.sw@gmail.com'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: env.GIT_BRANCH, 
                    url: env.GIT_URL, 
                    credentialsId: env.GIT_CREDENTIALS_ID
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh """
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                    """
                }
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            emailext(
                subject: "✅ Jenkins Pipeline Başarılı: ${env.JOB_NAME}",
                body: "Docker image başarıyla build edildi ve Docker Hub'a gönderildi:\n\n${DOCKER_IMAGE}:${DOCKER_TAG}",
                to: "${env.EMAIL_RECIPIENTS}"
            )
        }
        failure {
            emailext(
                subject: "❌ Jenkins Pipeline Hatalı: ${env.JOB_NAME}",
                body: "Pipeline başarısız oldu. Jenkins logunu kontrol et: ${env.BUILD_URL}",
                to: "${env.EMAIL_RECIPIENTS}"
            )
        }
    }
}

