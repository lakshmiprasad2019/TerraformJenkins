resource "aws_instance" "ec2_jenkins" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # key name
  key_name = "terraform"

  user_data = <<EOF
		#! /bin/bash
        sudo yum update -y
	amazon-linux-extras install java-openjdk11 -y
    curl --silent --location https://pkg.jenkins.io/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum install -y jenkins
    systemctl start jenkins
    systemctl status jenkins
    systemctl enable jenkins

	   EOF

  tags = {
    Name = "Ec2-User-data"
  }
}