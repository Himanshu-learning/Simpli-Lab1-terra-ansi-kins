resource "aws_instance" "web" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.SMP1510_SG.name]
  key_name = "himanshu"
  user_data = templatefile("./install_jenkins.sh", {})

  tags = {
    Name = "Lab1-Ansible-Jenkins"
  }

  root_block_device {
    volume_size = 8
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "himanshu"
  public_key = file("${path.module}/id_rsa.pub")
}

output "keyname" {
  value = "${aws_key_pair.deployer.key_name}"
}

resource "aws_security_group" "SMP1510_SG" {
  name        = "Lab1-Ansible-Jenkins"
  description = "Security group or SimpliLearn Lab1"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "RDP"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "JENKINS"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "SG-Ansible-Jenkins"
  }
}
