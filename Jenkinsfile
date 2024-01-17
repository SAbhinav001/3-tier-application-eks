pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
        IMAGE = "my-app"
        VERSION = "${env.BUILD_ID}"

    }

    stages {
        stage('checkou SCM') {
            steps {
               script{
                  git branch: 'main', url: 'https://github.com/SAbhinav001/custom_mod_2_tier_app.git'
               }
            }
        }
        
        stage('build') {
            steps {
                echo 'build'
                sh 'docker build -t ${IMAGE} .'
            }
        }
        
        stage('push') {
            steps {
                echo 'push'
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                    sh "docker login -u $USERNAME -p $PASSWORD"
                    sh "docker tag ${IMAGE} $USERNAME/${IMAGE}:${VERSION}"
                    sh "docker push $USERNAME/${IMAGE}:${VERSION}"
                }
            }
        }


        stage('Initializing Terraform') {
            steps {
                script{
                    dir('terraform/eks'){
                        sh 'terraform init'
                    }
                }
            }
        } 
        stage('Formatting Terraform Code'){
            steps{
                script{
                    dir('terraform/eks'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform'){
            steps{
                script{
                    dir('terraform/eks'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the Infra'){
            steps{
                script{
                    dir('terraform/eks'){
                        sh 'terraform plan'
                    }
                }
            }
        }
        stage('Create/Destroy an EKS Cluster'){
            steps{
                script{
                    dir('terraform/eks') {
                        sh 'terraform $action --auto-approve'
                    }
                     sh 'aws eks update-kubeconfig --name my-eks-cluster'
                }
            }
        }
        
        stage('Trigger ManifestUpdate job') {
                steps{
                    echo "triggering updatemanifestjob"
                    build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: "${VERSION}")]
                }
        }
        
    }
    
}
