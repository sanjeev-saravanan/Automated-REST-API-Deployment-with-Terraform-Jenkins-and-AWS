#!/bin/bash

# Exit script on any error
set -e

# Update and upgrade packages
echo "Updating package list and upgrading existing packages..."
sudo apt-get update && sudo apt-get upgrade -y

# Ensure required packages are installed
echo "Installing necessary dependencies..."
sudo apt-get install -y wget curl unzip apt-transport-https ca-certificates gnupg lsb-release

# Install OpenJDK 17 (latest LTS version)
echo "Installing OpenJDK 17..."
sudo apt-get install -y openjdk-17-jdk-headless

# Add Jenkins repository and key
echo "Adding Jenkins repository and key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list again
echo "Updating package list to include Jenkins..."
sudo apt-get update

# Install Jenkins
echo "Installing Jenkins..."
sudo apt-get install -y jenkins

# Start and enable Jenkins service
echo "Starting and enabling Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl restart jenkins

# Verify Jenkins status
echo "Checking Jenkins service status..."
if systemctl is-active --quiet jenkins; then
  echo "Jenkins is running successfully!"
else
  echo "Jenkins failed to start!" >&2
  exit 1
fi

# Install Terraform
TERRAFORM_VERSION="1.6.5" # Update this variable for newer versions
echo "Installing Terraform ${TERRAFORM_VERSION}..."
wget -q "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

sudo apt-get install -y unzip
unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
chmod +x terraform
sudo mv terraform /usr/local/bin/

# Clean up downloaded files
echo "Cleaning up..."
rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

# Verify installations
echo "Verifying installations..."
java --version
jenkins --version
terraform --version

echo "Installation completed successfully!"
