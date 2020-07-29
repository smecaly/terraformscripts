variable "aws_region" {
  default = "us-east-1"
}
variable "demo_access_key" {
}

variable "demo_secret_key" {
}


variable "path_to_private_key" {
  default = "ansiblekey"
}
variable "demo_instance_type" {
  default = "t2.micro"
  
}


variable "path_to_public_key" {
  default = "ansiblekey.pub"
}
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-09d8b5222f2b93bf0"
    us-east-2 = "ami-06b94666"
    us-east-3 = "ami-0d729a60"
  }
}

