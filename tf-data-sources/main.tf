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


// Below is one eaxmple of "data sources". Here we are fetching "ami from our aws cloud account"

data "aws_ami" "name" {  // by this data source, we are fetching the ami from aws.
  most_recent = true   // we are requesting for most recent ami. Also, we are not aware about any specific ami id so we are pulling the most recent availabe ami from cloud acount.
  owners = ["amazon"]   // owner is amazon. 
}

// the above one will fetch the ami block from ec2 > images > AMI Catalog. To test it, the output can be fetch in the below terminal.

/* output "test_output" {
  value = data.aws_ami.name  // by this, we will know the complete ami that will be fetched with ami id and then we can use that ami id over here.
} */

// now if we want we can fetch the specific id so the above will have a bit change.
// this .id fetches only ami id instead of complete block.

output "ami_output" {
  value = data.aws_ami.name.id
}

// Above was the example of dynamic data where the ami and it's related things were pulled from aws cloud.

//now same way we can pull security group details from our cloud account.check "name"

data "aws_security_group" "name" {
  tags = {
    name = "nginx-sg"  // here this is the tag value that you created in your sg. Name represents key and ngnix-sg represents it's value.
  }
}

output "sg-output" {
  value = data.aws_security_group.name.id
}


// same way we can pull vpc details.


data "aws_vpc" "tf-vpc" {
  tags = {
    Name = "my_vpc"
  }
}

output "vpc-output" {
  value = data.aws_vpc.tf-vpc.id
}

//Below is for the availability zones.

data "aws_availability_zones" "name" {
  state = "available"
}

output "available-zones" {
  value = data.aws_availability_zones.name.id
}


// To pull the caller (account) details fetching the data from cloud.

data "aws_caller_identity" "caller_account_detail" {   // this will fetching all the details including account_id, arn, id, user_id. For any specific details, the value can be written over here.
  
}

data "aws_region" "region-name" {  // this to fetch account region details.
  
}


output "caller_account_detail_from__above" {
  value = data.aws_caller_identity.caller_account_detail
}


output "region-name-for-account" {
  value = data.aws_region.region-name  
}


resource "aws_instance" "My_TF_Web_Server" { // here aws_instance is resource type and then we have the resource name
  ami = "ami-04b4f1a9cf54c11d0"  // ubuntu was selected so over their we were having the AMI ID. We haeve pasted the same thing over here. No need to type ubuntu and all.
  instance_type = "t2.micro"
  tags = {
    Name = "terraformServer"
  }
}


