provider "aws" {
  region     = "ap-southeast-2"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow inbound ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "play" {
  ami           = "ami-258f7947"
  instance_type = "t2.micro"
  security_groups = ["allow_ssh"]
}
