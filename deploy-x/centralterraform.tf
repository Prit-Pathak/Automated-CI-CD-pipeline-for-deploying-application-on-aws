provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA3FLD5Y36H4JW3I3T"
  secret_key = "zTmUti8t0ihlNveK2y6uYRI2YeevO3CLJ5ME8B5A"
}

resource "aws_instance" "web" {
  count             = 2
  ami               = "ami-02b49a24cfb95941c"  # Replace with an appropriate AMI ID for your region
  instance_type     = "t2.micro"
#   key_name           = "your-key-pair"  # Replace with your key pair name
  security_groups   = [aws_security_group.web_sg.name]
  
  tags = {
    Name = "web-instance-${count.index + 1}"
  }
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

