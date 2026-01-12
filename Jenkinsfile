pipeline {
    agent any

    environment {
        TF_VAR_FILE = ""
        DEPLOY_ENV  = ""
    }

    stages {

        stage('Detect Branch') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        env.TF_VAR_FILE = 'prod.tfvars'
                        env.DEPLOY_ENV  = 'PRODUCTION'
                    } else if (env.BRANCH_NAME == 'develop') {
                        env.TF_VAR_FILE = 'dev.tfvars'
                        env.DEPLOY_ENV  = 'DEVELOPMENT'
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
                    }

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
                bat 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat "terraform plan -var-file=%TF_VAR_FILE%"
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Approve deployment to ${env.DEPLOY_ENV}?"
                bat "terraform apply -auto-approve -var-file=%TF_VAR_FILE%"
            }
        }
    }
}
