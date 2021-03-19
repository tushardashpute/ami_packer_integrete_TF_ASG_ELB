variable "ami" {
  description = "AMI Instance ID"
  default = "ami-0d82032b6f0dcb256"
}

variable "instance_type" {
  description = "Type of instance"
  default = "t2.micro"
}

variable "key_name" {
  description = "key name for the instance"
  default = "tushar_test"
}