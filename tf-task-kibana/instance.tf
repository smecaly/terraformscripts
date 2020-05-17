resource "aws_instance" "BangaruEc2" {
    ami = var.AMIS[var.aws_region]
    instance_type = "t2.medium"
    subnet_id = aws_subnet.Bangaru-main-public-1.id
    vpc_security_group_ids = [aws_security_group.BangaruSg.id]
    key_name = "elk_key"
    tags = {
      Name = "Bangaru-LogStash_Instance"
    }
}


resource "aws_security_group" "BangaruSg" {
    vpc_id = aws_vpc.BangaruVpc.id
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "BangaruSg"
    }
}


output "instance_public_ip" {
  value = "${aws_instance.BangaruEc2.public_ip}"
}
