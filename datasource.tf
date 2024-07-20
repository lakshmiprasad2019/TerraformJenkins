data "aws_ami" "app_ami" {
  owners      = ["amazon"]
  most_recent = true


  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10**"]
  }
}