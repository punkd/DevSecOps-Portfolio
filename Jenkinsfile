pipeline {
  agent any

  environment {
    IMAGE_NAME = 'flask-secure-app'
  }

  stages {
    stage('📥 Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('🐍 Set Up Python Environment') {
      steps {
        sh '''
          python3 -m venv venv
          . venv/bin/activate
          pip install --upgrade pip
          pip install -r requirements.txt flake8 bandit
        '''
      }
    }

    stage('�� Lint Code (flake8)') {
      steps {
        sh '''
          source venv/bin/activate
          flake8 app.py || true
        '''
      }
    }

    stage('🔐 Security Scan (Bandit)') {
      steps {
        sh '''
          source venv/bin/activate
          bandit -r . -f json -o bandit-report.json || true
        '''
      }
      post {
        always {
          archiveArtifacts artifacts: 'bandit-report.json', allowEmptyArchive: true
        }
      }
    }

    stage('🐳 Docker Build') {
      steps {
        sh '''
          docker build -t $IMAGE_NAME .
        '''
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline completed successfully.'
    }
    failure {
      echo '❌ Pipeline failed.'
    }
  }
}
