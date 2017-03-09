variable "ami_id" {}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "doge-application-dev-env" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.doge-application-dev.id}"]
    tags { Name = "Doge Application - Development Environment" }
}

resource "aws_security_group" "doge-application-dev" {
    name = "doge-application-dev"

    ingress {
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 8080
      to_port = 8080
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

}

data "terraform_remote_state" "doge-application-dev-env-terraform-state" {
    backend = "s3"
    config {
        bucket = "doge-application"
        key = "terraform/dev-env-terraform.tfstate"
        region = "us-east-1"
    }
}
