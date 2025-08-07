# DevSecOps Pipeline Project

## 🎯 Project Goal
Build and automate a secure Flask application deployment pipeline using DevSecOps best practices. This project demonstrates:
- Infrastructure as Code (Terraform)
- CI/CD (Jenkins)
- Containerization (Docker)
- Security Scanning (Bandit, Trivy, Checkov)
- Deployment to AWS (ECS/Fargate or EC2)

---

## ✅ Project Components

### 📦 Application
- **Language**: Python (Flask)
- **Files**:
  - `app.py`: Minimal Flask web app
  - `requirements.txt`: Python dependencies
  - `Dockerfile`: Container image builder
  - `.gitignore`: Standard Python/Docker ignores

### 🔐 DevSecOps Tooling
- **CI/CD**: Jenkins
- **Security Scans**: Bandit, Trivy
- **Docker**: Local and cloud-based image building
- **Cloud Deployment**: AWS ECS via Terraform (planned)

---

## 🚀 CI Pipeline Overview (Jenkins)

| Stage             | Description                                        |
|------------------|----------------------------------------------------|
| `Checkout`        | Clone source code from GitHub                     |
| `Python Env`      | Install Python packages and security tools         |
| `Lint`            | Run code linting with flake8                       |
| `Security Scan`   | Run Bandit for static code analysis               |
| `Docker Build`    | Build a Docker image for the Flask app            |
| `Artifacts`       | Archive Bandit report for visibility              |

---

## 🧱 File Tree
```
devsecops-pipeline/
├── app.py
├── requirements.txt
├── Dockerfile
├── .gitignore
├── Jenkinsfile   # Coming next
├── bandit-report.json (artifact)
```


## 📧 Contact
Built by [punkd](https://github.com/punkd) as part of a DevSecOps portfolio.