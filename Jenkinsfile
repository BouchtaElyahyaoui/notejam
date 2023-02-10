pipeline {
    agent any
    environment {
        PROJECT_ID = 'protean-bit-376817'
                CLUSTER_NAME = 'cluster-1'
                LOCATION = 'uc-central1-c'
                CREDENTIALS_ID = 'kubernetes'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        
        stage('Push image') {
            steps {
                script {
                        withCredentials([usernamePassword(credentialsId: 'my-docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t bouchtadocker/pipeline:${env.BUILD_ID} .'
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        sh 'docker push bouchtadocker/pipeline:${env.BUILD_ID}' 
                    }
                    
                 }
                                 
            }
        }
    
        stage('Deploy to K8s') {
            steps{
                echo "Deployment started ..."
                sh 'ls -ltr'
                sh 'pwd'
                sh "sed -i 's/pipeline:latest/pipeline:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', \
                  projectId: env.PROJECT_ID, \
                  clusterName: env.CLUSTER_NAME, \
                  location: env.LOCATION, \
                  manifestPattern: 'deployment.yaml', \
                  credentialsId: env.CREDENTIALS_ID, \
                  verifyDeployments: true])
                }
            }
        }    
}
