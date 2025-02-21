terraform {
  backend "s3" {
    bucket = "tf-jenkins-proj-1-remote-state-bucket-123456"
    key    = "devops-project-1/terraform.tfstate"
    region = "us-east-1"
  }
}