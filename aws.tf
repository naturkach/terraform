
/*
tf to run web server on ami2
*/

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "webserver" {
  ami                    = "ami-07d2cd50077a70430"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  user_data              = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo service httpd start
sudo groupadd www
sudo usermod -a -G www ec2-user
sudo chgrp -R www /var/www
sudo chmod 2775 /var/www
sudo find /var/www -type d -exec sudo chmod 2775 {} +
sudo find /var/www -type f -exec sudo chmod 0664 {} +
curl http://169.254.169.254/latest/meta-data/local-ipv4  > index.html
echo "<br>">>index.html
curl http://169.254.169.254/latest/meta-data/public-ipv4 >>index.html
sudo cp index.html /var/www/html/
EOF

  tags = {
    Name  = "web server"
    Owner = "An Nat"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "testkey"
  public_key = ""
}


resource "aws_security_group" "allow_web" {
  name        = "allow_webport"
  description = "allow_webport"


  ingress {
    description = "web port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #any proto
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

