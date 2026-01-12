resource "aws_instance" "example" {
  ami           = "ami-0f5ee92e2d63afc18" # Amazon Linux 2 (Mumbai)
  instance_type = var.instance_type

  tags = {
    Name        = "Terraform-${var.environment}"
    Environment = var.environment
  }
}
