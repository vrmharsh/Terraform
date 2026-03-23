

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.89.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


/* locals {
   name="abc"  this is example of local variable.
   dep="dev"
} */

resource "aws_instance" "My_TF_Web_Server" { // here aws_instance is resource type and then we have the resource name
  ami = "ami-04b4f1a9cf54c11d0"  // ubuntu was selected so over their we were having the AMI ID. We haeve pasted the same thing over here. No need to type ubuntu and all.
  instance_type = var.aws_instance_variable


  root_block_device {
    delete_on_termination = true
    volume_size =  var.ec2_config.volume_size  // variables created for this
    volume_type =  var.ec2_config.volume_type  // variable created for this
  }


  tags = merge(var.additional_tags, { // so any tags created will get merged with this ccommon tag.
    Name = "terraformServer"
    /* Name = local.name (here we are calling local variables from above) */ 
  })
}


