resource "aws_instance" "siddesh-temp" {
  ami = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  subnet_id = var.AWS_SUBNET
  associate_public_ip_address = true

  provisioner "local-exec" {
    command = "echo ${aws_instance.siddesh-temp.private_ip} >> private_ips.txt"
  }
}

output "ip" {
  value = aws_instance.siddesh-temp.public_ip
}