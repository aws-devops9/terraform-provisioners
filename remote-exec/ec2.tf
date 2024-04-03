resource "aws_instance" "web" {
  ami           = "ami-0f3c7d07486cad139"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.roboshop-remote-exec.id] # we have to give [] because it is a string

  tags = {
    Name = "Provisioner"
  }


#   provisioner "local-exec" {
#     command = "echo This will execute at the time of creation"
# }

#   provisioner "local-exec" {
#     command = "echo ${self.private_ip} > inventory" # self = aws_instance.web
# }

#   provisioner "local-exec" {
#     command = "echo This will execute at the time of destroy"
#     when = destroy
# }

  connection {
    type = "ssh"
    user = "centos"
    password = "DevOps321"
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "echo 'This is from Remote-Exec' > /tmp/remote.txt",
        "sudo yum install nginx -y",
        "sudo systemctl start nginx"
    ]
  }
}

resource "aws_security_group" "roboshop-remote-exec" { # This is terraform name for terraform reference only
  name        =  "remote-exec"
  
  ingress {
    description = "Allow-All-Ports"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow-All-Ports"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    tags = {
        Name = "Provisioner"
}
}