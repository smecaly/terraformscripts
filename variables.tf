variable "aws_region" {
  default = "us-east-1"
}
variable "demo_access_key" {
}

variable "demo_secret_key" {
}


variable "path_to_private_key" {
  default = "demokey"
}
variable "demo_instance_type" {
  default = "t2.micro"
  
}


variable "path_to_public_key" {
  default = "demokey.pub"
}
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-03e1e4abf50e14ded"
    us-east-2 = "ami-06b94666"
    us-east-3 = "ami-0d729a60"
  }
}

