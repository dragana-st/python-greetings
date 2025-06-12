pipeline {
    agent any
    triggers {
        pollSCM('*/1 * * * *')
    }
    stages {
        stage('build-docker-image') {
            steps {
                echo "Obtaining code from GitHub repository"
                git branch: "main", url: "https://github.com/dragana-st/python-greetings.git"

                echo "Building docker image from Dockerfile"
                sh "docker build -t draganast/python-greetings-app:latest ."

                echo "Pushing docker image to Docker Hub"
                sh "docker push draganast/python-greetings-app:latest"
            }
        }

        stage('deploy-to-dev') {
            steps {
                deploy("dev")
            }
        }

        stage('tests-on-dev') {
            steps {
                test("dev")
            }
        }

        stage('deploy-to-stg') {
            steps {
                deploy("stg")
            }
        }

        stage('tests-on-stg') {
            steps {
                test("stg")
            }
        }

        stage('deploy-to-prod') {
            steps {
                deploy("prd")
            }
        }

        stage('tests-on-prod') {
            steps {
                test("prd")
            }
        }
    }
}

def deploy(String environment) {
    echo "Deploying Python microservice to ${environment} environment.."
    sh "docker pull draganast/python-greetings-app:latest"
    sh "docker compose stop greetings-app-${environment}"
    sh "docker compose rm greetings-app-${environment}"
    sh "docker compose up -d greetings-app-${environment}"
}

def test(String environment) {
    echo "Testing Python microservice in ${environment} environment.."
    sh "docker pull draganast/api-tests:latest"
    sh "docker run --network=host --rm draganast/api-tests:latest run greetings greetings_${environment}"
}