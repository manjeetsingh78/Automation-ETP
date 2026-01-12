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
                    def tfVarFile = ""
                    def deployEnv = ""

                    if (env.BRANCH_NAME == 'main') {
                        tfVarFile = 'prod.tfvars'
                        deployEnv = 'PRODUCTION'
                    } else if (env.BRANCH_NAME == 'develop') {
                        tfVarFile = 'dev.tfvars'
                        deployEnv = 'DEVELOPMENT'
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
                    }

                    env.TF_VAR_FILE = tfVarFile
                    env.DEPLOY_ENV  = deployEnv

                    echo "===================================="
                    echo "Branch Name      : ${env.BRANCH_NAME}"
                    echo "Deployment Env   : ${env.DEPLOY_ENV}"
                    echo "Terraform VarFile: ${env.TF_VAR_FILE}"
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
