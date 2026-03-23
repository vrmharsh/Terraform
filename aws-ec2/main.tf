

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.89.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "My_TF_Web_Server" { // here aws_instance is resource type and then we have the resource name
  ami = "ami-04b4f1a9cf54c11d0"  // ubuntu was selected so over their we were having the AMI ID. We haeve pasted the same thing over here. No need to type ubuntu and all.
  instance_type = "t2.micro"
  tags = {
    Name = "terraformServer"
  }
}
