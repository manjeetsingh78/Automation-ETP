pipeline {
    agent any

    environment {
        TF_VAR_FILE = ""
        DEPLOY_ENV  = ""
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Detect Branch') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        TF_VAR_FILE = 'prod.tfvars'
                        DEPLOY_ENV  = 'PRODUCTION'
                    } else if (env.BRANCH_NAME == 'develop') {
                        TF_VAR_FILE = 'dev.tfvars'
                        DEPLOY_ENV  = 'DEVELOPMENT'
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
                    }

                    echo "===================================="
                    echo "Branch Name      : ${env.BRANCH_NAME}"
                    echo "Deployment Env   : ${DEPLOY_ENV}"
                    echo "Terraform VarFile: ${TF_VAR_FILE}"
                    echo "===================================="
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh "terraform plan -var-file=${TF_VAR_FILE}"
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Approve deployment to ${DEPLOY_ENV}?"
                sh "terraform apply -auto-approve -var-file=${TF_VAR_FILE}"
            }
        }
    }
}
