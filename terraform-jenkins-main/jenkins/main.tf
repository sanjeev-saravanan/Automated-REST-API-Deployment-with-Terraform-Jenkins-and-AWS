variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_for_jenkins" {}
variable "enable_public_ip_address" {}
variable "user_data_install_jenkins" {}


output "ssh_connection_string_for_ec2" {
  value = format("%s%s", "ssh -i /home/sanjeev/.ssh/tf_jenkins_proj ubuntu@", aws_instance.jenkins_ec2_instance_ip.public_ip)
}

output "jenkins_ec2_instance_ip" {
  value = aws_instance.jenkins_ec2_instance_ip.id
}

output "tf_jenkins_proj_1_ec2_instance_public_ip" {
  value = aws_instance.jenkins_ec2_instance_ip.public_ip
}

resource "aws_instance" "jenkins_ec2_instance_ip" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name                    = "tf_jenkins_proj"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_for_jenkins
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_jenkins

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }

  lifecycle {
    prevent_destroy = true  # Stops accidental deletion
    ignore_changes  = [ami, user_data, tags]
  }

  root_block_device {
    volume_size           = 8  # Match the current volume size
    delete_on_termination = false
  }
}




resource "aws_key_pair" "jenkins_ec2_instance_public_key" {
  key_name   = "tf_jenkins_proj"
  public_key = var.public_key
}

