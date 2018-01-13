variable "PUBLIC_SSH_KEY" {}

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
}

resource "aws_key_pair" "ssh-key"{
  key_name = "play-key"
  public_key = "${var.PUBLIC_SSH_KEY}"
}

resource "aws_instance" "play" {
  ami           = "ami-258f7947"
  instance_type = "t2.micro"
  security_groups = ["allow_ssh"]
  key_name = "play-key"
  user_data = "${file("motd.tpl")}"
}

output "play_dns" {
  value = ["${aws_instance.play.public_dns}"]
}
