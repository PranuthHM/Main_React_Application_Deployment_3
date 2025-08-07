# 🚀 Main React Application Deployment – CI/CD Pipeline with Jenkins & Docker

This project demonstrates the **end-to-end CI/CD deployment** of a **React application** using **Jenkins**, **Docker**, and **Docker Hub**, deployed on an **AWS EC2 instance**, with **Prometheus and Grafana** for monitoring.

---

## 📚 Table of Contents
- [📖 Project Overview](#-project-overview)
- [🛠 Prerequisites](#-prerequisites)
- [📂 Project Structure](#-project-structure)
- [1️⃣ Step 1: Clone & Configure Git Repository](#1️⃣-step-1-clone--configure-git-repository)
- [2️⃣ Step 2: Dockerization](#2️⃣-step-2-dockerization)
- [3️⃣ Step 3: Bash Automation Scripts](#3️⃣-step-3-bash-automation-scripts)
- [4️⃣ Step 4: Docker Hub Setup](#4️⃣-step-4-docker-hub-setup)
- [5️⃣ Step 5: Jenkins Setup](#5️⃣-step-5-jenkins-setup)
- [6️⃣ Step 6: Jenkins Pipeline CI/CD](#6️⃣-step-6-jenkins-pipeline-cicd)
- [7️⃣ Step 7: Production Deployment](#7️⃣-step-7-production-deployment)
- [8️⃣ Step 8: Monitoring with Prometheus & Grafana](#8️⃣-step-8-monitoring-with-prometheus--grafana)
- [🧹 Cleanup](#-cleanup)
- [📌 References](#-references)

---

## 📖 Project Overview
The project automates the deployment of a **React web application** using:
- **GitHub** – Source code repository
- **Jenkins** – CI/CD automation
- **Docker** – Containerization
- **Docker Hub** – Image repository
- **AWS EC2** – Deployment server
- **Prometheus & Grafana** – Monitoring

Workflow:
1. Developer pushes code to GitHub (`dev` or `master` branch).
2. GitHub webhook triggers Jenkins pipeline.
3. Jenkins builds a Docker image, pushes it to Docker Hub.
4. EC2 instance pulls and runs the latest image.
5. Prometheus & Grafana monitor application performance.

---

## 🛠 Prerequisites
Before starting, ensure you have:
- **AWS Account** with EC2 access
- **Docker Hub account**
- **GitHub repository**
- Installed locally:
  - [Git](https://git-scm.com/downloads)
  - [Docker Desktop](https://www.docker.com/products/docker-desktop)
  - [Jenkins](https://www.jenkins.io/)
  - [WSL (for Windows)](https://learn.microsoft.com/en-us/windows/wsl/)

---

## 📂 Project Structure
Main_React_Application_Deployment_3/
│
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .gitignore
├── build.sh
├── deploy.sh
├── Jenkinsfile
└── src/ (React app source code)


---

## 1️⃣ Step 1: Clone & Configure Git Repository
```bash
git clone https://github.com/sriram-R-krishnan/devops-build.git
cd devops-build
```

# Initialize and configure new repository
``` bash
git init
nano .gitignore  # Add ignore rules
git commit -m "Initial commit"
git remote add origin https://github.com/PranuthHM/Main_React_Application_Deployment_3.git
git checkout -b dev
git push -u origin dev
```
## 2️⃣ Step 2: Dockerization

   Dockerfile: Uses Nginx to serve the React build.

  .dockerignore: Excludes unnecessary files from the image.

  docker-compose.yml: Runs the app locally.

Test locally:

```bash
docker-compose up -d
# Visit http://localhost:80
docker-compose down
```

## 3️⃣ Step 3: Bash Automation Scripts

  build.sh: Builds and pushes Docker image to Docker Hub.

  deploy.sh: Pulls image from Docker Hub and runs it on EC2.

Run locally:

``` bash
chmod +x build.sh deploy.sh
./build.sh
./deploy.sh
```

## 4️⃣ Step 4: Docker Hub Setup

   Create dev (public) and prod (private) repositories.

  Push images via build.sh script.

## 5️⃣ Step 5: Jenkins Setup

   Launch Ubuntu EC2 instance.

  Install Jenkins & Docker.

  Configure Jenkins to run Docker commands.

## 6️⃣ Step 6: Jenkins Pipeline CI/CD

   Jenkinsfile handles:

      Code checkout
      Docker build & push
      Deployment to EC2

  GitHub Webhook triggers builds automatically.

## 7️⃣ Step 7: Production Deployment
  
  Merge dev → master

  Jenkins deploys from prod Docker Hub repo to EC2.

## 8️⃣ Step 8: Monitoring with Prometheus & Grafana

  Install Prometheus & Grafana on EC2.

  Collect metrics and visualize on Grafana dashboards.
  
##🧹 Cleanup
docker stop react-app-container && docker rm react-app-container
docker rmi <image_id>
