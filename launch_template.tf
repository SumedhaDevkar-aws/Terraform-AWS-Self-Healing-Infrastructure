resource "aws_launch_template" "app_template" {
  name_prefix   = "app-template-"
  image_id      = "ami-0dee22c13ea7a9a67" # Amazon Linux 2023 (use latest for ap-south-1)
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from Sumedha's Auto-Healing EC2 Instance!" > /var/www/html/index.html
              EOF
  )

  tags = {
    Name = "app-template"
  }
}
