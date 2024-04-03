resource "aws_instance" "web" {
  ami           = "ami-0f3c7d07486cad139"
  instance_type = "t2.micro"

  tags = {
    Name = "Provisioner"
  }


  provisioner "local-exec" {
    command = "echo This will execute at the time of creation"
}

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory" # self = aws_instance.web
}

  provisioner "local-exec" {
    command = "echo This will execute at the time of destroy"
    when = destroy
}
}
