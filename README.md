# Automated REST API Deployment with Terraform, Jenkins, and AWS 🚀

This project focuses on **automating the deployment of a REST API application** using **Terraform** for infrastructure provisioning and **Jenkins** for CI/CD pipeline management. The infrastructure is built on **AWS** and is designed to be **secure, scalable, and highly available**.

---

## Overview 🌟

The project automates the following:

1. **Infrastructure Provisioning**:
   - Uses **Terraform** to create a secure and scalable AWS infrastructure.
   - Provisions resources like **EC2 instances, RDS databases, VPC, ALB, ACM certificates, Route 53, and more**.
   - Stores Terraform state remotely in an **S3 bucket** for collaboration and reliability.

2. **CI/CD Pipeline**:
   - Uses **Jenkins** to automate the deployment of the REST API application to EC2 instances.
   - Ensures seamless updates and rollbacks for the application.

---

## Technologies Used 🛠️

- **Terraform**: Infrastructure as Code (IaC) for provisioning AWS resources.
- **Jenkins**: CI/CD pipeline for automated deployment.
- **AWS Services**:
  - **EC2**: Hosts the REST API application.
  - **RDS**: Managed database for the application.
  - **VPC**: Isolated network environment.
  - **ALB & Target Groups**: Load balancing and traffic routing.
  - **ACM**: SSL/TLS certificates for secure communication.
  - **Route 53**: DNS management.
  - **S3**: Remote Terraform state management.
  - **Security Groups**: Ensures secure access to resources.

---

## Key Features ✨

- **Automated Infrastructure**: Terraform scripts to provision and manage AWS resources.
- **CI/CD Pipeline**: Jenkins automates the build, test, and deployment process.
- **Scalable and Secure**: Designed for high availability and security using AWS best practices.
- **Centralized State Management**: Terraform state stored in an S3 bucket for team collaboration.

---

## Setup Instructions 📝

### Prerequisites

1. **AWS Account**: With necessary permissions to create resources.
2. **Terraform**: Installed and configured on your local machine.
3. **Jenkins**: Installed and running (can be on a local server or EC2 instance).

### Steps to Run the Project

1. **Clone the Repository:**:
   ```bash
   git clone https://github.com/your-repo/Automated-REST-API-Deployment-with-Terraform-Jenkins-and-AWS.git
   cd Automated-REST-API-Deployment-with-Terraform-Jenkins-and-AWS
   
2. **Configure AWS Credentials:**
- Set up your AWS credentials using the AWS CLI or environment variables.

3. **Initialize Terraform:**
```bash
terraform init
```
4. **Plan and Apply Terraform Configuration:**
  ```bash
  terraform init  
  terraform apply -auto-approve  
 ```

5. **Set Up Jenkins Pipeline:**
- Configure Jenkins with the necessary plugins.
- Create a pipeline job and link it to the repository.
- Add build and deployment scripts to the pipeline.

6. **Deploy the REST API:**
- Trigger the Jenkins pipeline to deploy the REST API application to the EC2 instances.

## Contributing 🤝

Got ideas to make this project even better? We'd love your input! Here's how you can contribute:

1. **Fork the Repository**: Create your own copy of the project.
2. **Create a New Branch**: Work on your feature or bugfix in a separate branch.
3. **Submit a Pull Request**: Describe your changes and why they should be merged.

Let's build something amazing together! 🚀

## Learn More 🔍

Want to dive deeper into how this project works? Check out the step-by-step tutorial here:  
[Automated REST API Deployment Tutorial](https://youtu.be/otQqd7GRVK0?si=-wvXKtoZFTpJ7TV0)
