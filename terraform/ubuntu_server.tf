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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDf9vlNiuCWTrMBbZgys6uqH9tOgSY5VEEtrQrSEz1W28bBw3vVbKaLtw3KXMw47KJWppCw+sDYQZFBy/lXpjFUjQ+j04qJyCdh0CaxVwG++whnax1wBi5EVL4GNdLBndbtvb+MSKuKvSnRABZfaByBvEdwgBaeENGDPnm0GEzGT0YDHa2isw6kei7FRDwOrWEQbF83yjTwtxAZ5AQoS51d89H2YYutStGZCvLcA7Yr9l9e7YumkpCAltzhzxCClkpLMrq3T00VbcU/+g9EchZ6H31BK7ShuBTD0LH7Nx9L0TjjRwxJF/Mwe0Pl479gC+E31qdtwCi3bTn8GdNqwVFQcvrsGCzfIy+H5beigBDc9GtwnI8b7VEaQq7wRffnU6+RwLZJkic4gVSUfKm4VoYtQh3/GNOiFm3DexLDiCXG0ib25PGQneW3co55o8FoS8imld6msq5N/rIfWihCgcW/IxPHTOPTqoAs2WCtAdm3oEfeYU+aLvpMWb+rAhINKLk77ugGNCyDZa3IG0NH6A/T9l1TAqvkvgiLRIso+WG4qZamTmy2/yn5EUyL9i3QTz71SmHUn5apXBIBFHm26Qm6aqg7TdPYCWVSbMSqwIGJuV3+j0E5fbNMjw5VpgCyhaaGMTX4LIqPHKK2hYtZoCsH3Te0GU5SfZ8mZhb1xsDJnw=="
}

resource "aws_instance" "play" {
  ami           = "ami-258f7947"
  instance_type = "t2.micro"
  security_groups = ["allow_ssh"]
  key_name = "play-key"
}
