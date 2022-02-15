provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-2"
}

resource "aws_instance" "test_env" {

  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  key_name               = "webserver"
  user_data              = <<EOF
#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo apt-get install openjdk-11-jre -y
EOF

  tags = {
    Name  = "Web server"
    Owner = "Ruslan Khomiachenko"
  }

}

resource "aws_instance" "prod_env" {

  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  key_name               = "webserver"
  user_data              = <<EOF
#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo apt-get install openjdk-11-jre -y
EOF

  tags = {
    Name  = "Prod Web server"
    Owner = "Ruslan Khomiachenko"
  }

}

resource "aws_security_group" "webserver" {
  name        = "Webserver_Security_Group"
  description = "Security Group"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web server"
    Owner = "Ruslan Khomiachenko"
  }
}

output "test_env" {
  value = aws_instance.test_env.public_ip
}

output "prod_env" {
  value = aws_instance.prod_env.public_ip
}

