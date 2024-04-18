 [![Deploy demo-app using Terraform to AWS](https://github.com/EzioDEVio/cicd-pipeline-demo/actions/workflows/demo-ci-cd.yml/badge.svg)](https://github.com/EzioDEVio/cicd-pipeline-demo/actions/workflows/demo-ci-cd.yml) [![Build and Push to Docker Hub](https://github.com/EzioDEVio/cicd-pipeline-demo/actions/workflows/dockerbuild.yml/badge.svg)](https://github.com/EzioDEVio/cicd-pipeline-demo/actions/workflows/dockerbuild.yml)  [![Trivy Vulnerability Scanning](https://github.com/EzioDEVio/cicd-pipeline-demo/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/EzioDEVio/cicd-pipeline-demo/actions/workflows/trivy-scan.yml) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=EzioDEVio_cicd-pipeline-demo&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=EzioDEVio_cicd-pipeline-demo) [![Bugs](https://sonarcloud.io/api/project_badges/measure?project=EzioDEVio_cicd-pipeline-demo&metric=bugs)](https://sonarcloud.io/summary/new_code?id=EzioDEVio_cicd-pipeline-demo) [![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=EzioDEVio_cicd-pipeline-demo&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=EzioDEVio_cicd-pipeline-demo) [![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=EzioDEVio_cicd-pipeline-demo&metric=duplicated_lines_density)](https://sonarcloud.io/summary/new_code?id=EzioDEVio_cicd-pipeline-demo) 

[![SonarCloud](https://sonarcloud.io/images/project_badges/sonarcloud-black.svg)](https://sonarcloud.io/summary/new_code?id=EzioDEVio_cicd-pipeline-demo)   
[![Security Scanning with Terrascan](https://github.com/EzioDEVio/cicd-pipeline-demo/actions/workflows/Terrascan.yml/badge.svg)](https://github.com/EzioDEVio/cicd-pipeline-demo/actions/workflows/Terrascan.yml)

[![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=EzioDEVio_cicd-pipeline-demo)](https://sonarcloud.io/summary/new_code?id=EzioDEVio_cicd-pipeline-demo)

# Project Documentation

## Overview

This project demonstrates a comprehensive CI/CD pipeline incorporating DevSecOps best practices using GitHub Actions. The application, a simple web server, is containerized using Docker, scanned for vulnerabilities with Trivy, and analyzed with SonarCloud to ensure code quality and security.

## Application

The core of this project is a basic web application developed in JavaScript/Node.js. It includes a simple HTTP server that responds to web requests. The application's functionality is minimalistic, designed primarily to illustrate the CI/CD pipeline process.

## CI/CD Pipeline

### Continuous Integration (CI)

The CI portion of our pipeline is orchestrated using GitHub Actions and includes the following steps:

1. **Code Checkout**: The pipeline checks out the latest code from the main branch to ensure that all subsequent actions work with the latest codebase.

2. **Build**: The application is built into a Docker container. This step ensures that the application is packaged correctly and is ready for deployment.

   - The `Dockerfile` in the repository defines the steps necessary to containerize the application, including setting up the environment, copying the source code, and defining the runtime command.

3. **Trivy Scan**: Trivy scans the Docker image for vulnerabilities. This scanning ensures that the container does not contain any known vulnerabilities, aligning with DevSecOps principles to integrate security into the early stages of development.

   - The results of the Trivy scan are reviewed, and if vulnerabilities are found, the pipeline can be configured to fail, prompting immediate remediation.

4. **SonarCloud Analysis**: SonarCloud analyzes the code quality, identifying bugs, vulnerabilities, and code smells. This step is crucial for maintaining high code standards and ensuring that technical debt is managed effectively.

   - The analysis results are made available on the SonarCloud dashboard, providing insights into the code quality and areas for improvement.

### DevSecOps Integration

The integration of Trivy and SonarCloud into the CI pipeline embodies the DevSecOps philosophy, where security and quality are not afterthoughts but integral parts of the development lifecycle.

- **Security**: By scanning the Docker image with Trivy, we ensure that our application's environment is free from known vulnerabilities. This proactive approach to security helps in mitigating risks well before deployment.

- **Quality**: SonarCloud's analysis provides a deep dive into the code's health, promoting best practices and preventing potential issues from progressing to later stages.

### Continuous Delivery (CD)

While this project focuses on the CI aspects, in a full CI/CD pipeline, the next steps would involve:

- **Artifact Storage**: Storing the built and scanned Docker image in a container registry.
- **Deployment**: Automatically deploying the Docker image to a production-like environment.
- **Monitoring**: Implementing monitoring and logging to track the application's performance and health in real-time.

## Conclusion

This project serves as a template for implementing a CI/CD pipeline with a strong emphasis on security and code quality. By integrating tools like Trivy and SonarCloud, we adhere to DevSecOps principles, ensuring that our application is secure, reliable, and maintainable.
