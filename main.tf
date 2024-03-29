provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "k8s-key" {
  key_name = "k8s-key"
  public_key = "" pubkey host para chavear a conexão

}

resource "aws_security_group" "k8s-sg" {
  
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  } 
}

resource "aws_instance" "kubernetes-worker" {
  ami = ami-0fc5d935ebf8bc3bc 
  instance_type = t2.micro 
  key_name = "k8s-key"
  count = 2
  tags = {
    name = "K8S"
    type = "Worker"
  }
  security_groups = ["${aws_aws_security_group.k8s-sg.name}"]
}

resource "aws_instance" "kubernetes-master" {
  ami = ami-0fc5d935ebf8bc3bc 
  instance_type = t2.micro
  key_name = "k8s-key"
  count = 1
  tags = {
    name = "K8S"
    type = "Master"
  }
  security_groups = ["${aws_aws_security_group.k8s-sg.name}"]
}