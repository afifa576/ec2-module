provider "aws" {
  region = var.region
}
resource "aws_vpc" "test" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "tf-example"
  }
}
resource "aws_security_group" "test4" {
     name        = "allow_ssh"
     description = "Allow SSH inbound traffic"
     vpc_id      = aws_vpc.test.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.test.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.test.id
  cidr_block = var.public_cidr

  tags = {
    Name = "Main"
  }
  
}
resource "aws_key_pair" "test7" {
    key_name   = "aws-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpc07kGZ9hQQve347Z5UudA72UIdjqWkMaIxu58Zuy0m0FD2W6q8Y8uE/nXD3F/jhNKYYKh+vRUJWzRxay3wjRFxzC7oNVUNE7DGyzCu8CqFm/oiTUXNg5+61q25Iabh+1AXUJWIamxIM7Ol735alBIW9ZIfrMUZzYYOoWfEhIl+/ht40PSjOrZMdfSibYZFJlXx42KYQW2EoUhO5om+TeldtGaqUo9wiA3T9OYum3bSjy4q/E5nXv3+wwzaEXpCSWGz1gAXt4ZvN0X5Xaf8U7vIz4p6FUBDTpvbIfkp9nhp2FBED43/WbsheZwWPFFq8OKc0j+0Bb5l9nNxC0/zSa5dt1jP0l0maZX0nPYUwV/bNjw7PW3g1x8wZxowXuplDwquz0/c4xWmKq0We5k82zlV7LYgS9636TynEwlmYkAFha2b+fOnE/a4FVqQByJUqm4nFOkxC3p0qT7URagQp4qfENzvh7ukkuMx6TUmeDtC1tUuw0GX4TUdn5jxFWKpM= farhan@farhan-PC"
}
resource "aws_instance" "my-instance" {
    ami           = var.my-ami
    instance_type = "t2.micro"
    key_name     = aws_key_pair.test7.id

  tags = {
    Name = "HelloWorld"
  }
}