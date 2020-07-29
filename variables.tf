variable "aws_region" {
}
variable "demo_access_key" {
}

variable "demo_secret_key" {
}

variable "demo_instance_type" {
  default = "t2.micro"
}
variable "demokeypair" {
}
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-09d8b5222f2b93bf0"
    us-east-2 = "ami-0e067567dbf210b67"
    us-east-3 = "ami-0d729a60"
  }
}

