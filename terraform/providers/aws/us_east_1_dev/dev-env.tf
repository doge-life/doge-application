variable "ami_id" {}
variable "doge_private_key_file" {}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "doge-application-dev-env" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.doge-application-dev.id}"]
    tags { Name = "Doge Application - Development Environment" }
    key_name = "doge-default"

    connection {
        user = "ubuntu"
        private_key = "${file(var.doge_private_key_file)}"
    }

    provisioner "file" {
        source = "doge-webapp.conf"
        destination = "~/doge-webapp.conf"
    }

    provisioner "remote-exec" {
        inline = ["sudo mv ~/doge-webapp.conf /var/doge-webapp/doge-webapp.conf", "sudo service doge-webapp restart"]
    }
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
