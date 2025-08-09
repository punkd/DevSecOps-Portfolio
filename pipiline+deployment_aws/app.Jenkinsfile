pipeline {
  agent any
  environment {
    IMAGE_NAME         = 'flask-secure-app'
    AWS_DEFAULT_REGION = 'us-east-1'
  }
  stages {
    stage('🔎 Diagnostics') {
      steps {
        sh '''
          echo "=== Versions ==="
          python3 --version || true
          docker --version || true
        '''
      }
    }
    stage('🐍 Setup + Lint + Bandit') {
      steps {
        sh '''
          python3 -m venv venv
          . venv/bin/activate
          pip install --upgrade pip
          pip install -r pipiline+deployment_aws/requirements.txt flake8 bandit
          flake8 pipiline+deployment_aws/app.py || true
          bandit -r pipiline+deployment_aws -f json -o bandit-report.json || true
        '''
      }
      post {
        always { archiveArtifacts artifacts: 'bandit-report.json', allowEmptyArchive: true }
      }
    }
    stage('🐳 Docker Build') {
      steps {
        sh 'docker build -t $IMAGE_NAME:latest pipiline+deployment_aws/.'
      }
    }
    stage('📦 Push to ECR') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: '3f776ff3-06c6-49bf-b7c8-2277e9d5b1f6',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
          sh '''
            set -e
            REPO_URL=$(aws ecr describe-repositories --repository-names ${IMAGE_NAME} \
              --query 'repositories[0].repositoryUri' --output text 2>/dev/null || true)
            if [ -z "$REPO_URL" ]; then
              echo "[INFO] Creating ECR repo ${IMAGE_NAME}…"
              aws ecr create-repository --repository-name ${IMAGE_NAME} >/dev/null
              REPO_URL=$(aws ecr describe-repositories --repository-names ${IMAGE_NAME} \
                --query 'repositories[0].repositoryUri' --output text)
            fi
            echo "[INFO] ECR: $REPO_URL"
            aws ecr get-login-password | docker login --username AWS --password-stdin $(echo $REPO_URL | cut -d'/' -f1)
            # tag with latest AND a short, traceable tag
            TAG=$(date +%Y%m%d%H%M%S)-${GIT_COMMIT:0:7}
            docker tag ${IMAGE_NAME}:latest $REPO_URL:latest
            docker tag ${IMAGE_NAME}:latest $REPO_URL:$TAG
            docker push $REPO_URL:latest
            docker push $REPO_URL:$TAG
            echo $REPO_URL:$TAG > .image_tag
          '''
        }
      }
      post {
        always { archiveArtifacts artifacts: '.image_tag', allowEmptyArchive: true }
      }
    }
  }
  post {
    success { echo '✅ App image built & pushed.' }
    failure { echo '❌ App pipeline failed.' }
  }
}
