resource "aws_instance" "siddesh-temp" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  tags = {
    Name = "${var.TAG}"
  }

  subnet_id = "${var.AWS_SUBNET}"
}