variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_cidr" {
  default = "10.0.10.0/24"
}

variable "public_cidr" {
  default = "10.0.1.0/24"
}
variable "region" {
  default = "us-east-1"
}
variable "my-keypair" {
   default = "aws-key"
}
variable "my-ami" {
    default = "ami-0dfcb1ef8550277af"
}
#variable "my-instance_type" {
 #   default = t2.micro
#}