
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.90.1"
    }
  }
}
  



module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"
}


provider "aws" {
  region = "us-east-1"
}


locals {
   project = "project-01"
}

resource "aws-vpc" "for-below-subnets" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${local.project}-VPC"  // so, this will be like "project-01-VPC"
    }
}

resource "aws-subnet" "public-subnet-one" {
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id = aws-vpc.for-below-subnets.id
  count = 2
  tags ={
    Name = "${local.project}-Subnet-ID-${count.index}"
  }
}


/* for the above one, count.index is 0 so index start with zero
   Overall value is starting with 0, so when 1st time, the above is running, it will create
   a subnet with cidr of 10.0.0.0/24

   Second time it runs then the count.index will be 1. 

   So, this will create a cidr block of 10.0.1.0/24


 */

// Now, if you want to create ay 10 subnets then either do it manually or use count.

/* resource "aws-subnet" "public-subnet-2" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws-vpc.for-below-subnets.id
} */



// now you have the above created two subnets. Now how to use them ? let's say you want to fetch it then how would you do it ?

output "test-of-count-output" {
  value = aws-subnet.public-subnet-one.id  /* this will fetch all the things */
}

// however, inoder to fetch specific one you need to do the below thing:

output "test-of-count-output-with-specific-ones" {
  value = aws-subnet.public-subnet-one[0 /* or 1 */].id  // this will fetch the specific ID's assignd to subnets in the output
}


// You need to use the above two subnets created and assign them to EC2 instances inside VPC’s. 


resource "aws_instance" "TF-EC2-Instance-one" {
  ami = "ami-04b4f1a9cf54c11d0"
 instance_type= "t2.micro"
 count = 4
 subnet_id = element (aws-subnet.public-subnet-one[*].id, count.index % length(aws-subnet.public-subnet-one))
 /* Explanation:
 1. element is the finction that helps you to have dynamic values. Inside, you need to give the "list"
 2. Why we use [*] ?? 
    Because we want to have all the values inside the list.
 3. Second part: 
    count.index will start from 0 to 3
    length function will give the exact length of the list.
    So, output will be like
    0 % 4 = 0
    1 % 4 = 1
    2 % 4 = 2
    3 % 4 = 3
 
This way we have achieved the values dynamically.
  */
  tags = {
    name = "${local.project}-TF-Server-For-Testing-one-${count.index}"
  }
}


// Create two EC2 instance with different engines, for eg: ubuntu and amazon-linux:

// 1. Below was the example of "count"

resource "aws_instance" "ubunt-amazon-linux" {

 count = length(var.ubuntu-amazonLinux-instances)  /*  this checks the length of this list and since it has two variables inside like ami 
 for ubuntu and linux so we are fetching like var dot */

 ami = var.ubuntu-amazonLinux-instances[count.index].ami  /* count.index =1 then it fetches first ami that is for ubunut and creates an
                                                      instance. Then goes for the second one */
 instance_type = var.ubuntu-amazonLinux-instances[count.index].instance_type

 subnet_id = element (aws-subnet.public-subnet-one[*].id, count.index % length(aws-subnet.public-subnet-one))
 /* same conept as the above dynmic subnet one */
  tags = {
    name = "${local.project}-TF-Server-For-Testing-one-${count.index}"
  }
}



// 2. Below is the example of "for_each"


resource "aws_instance" "ubunt-amazon-linux-with-each" {

for_each = var.ec2_map  // this will fetch the variable name ec2_map in terraform.tfvars so we need to write it with var

ami = each.value.ami  // here in continution to the above for_each, we fetch the value instead of key and then the ami part.
instance_type = each.value.instance_type  // here in continution to the above for_each, we fetch the value instead of key and then the instance_type

 subnet_id = element (aws-subnet.public-subnet-one[*].id, index(key(var.ec2_map), each.key ) % length(aws-subnet.public-subnet-one))

/* here the subnet part has the same explanation except of that index:
index(key(var.ec2_map), each.key ) 

here each.key is the current iteration and key(var.ec2_map) gives the full list of variables
In this case, we have "ubuntu" and "amazon linux" in the complete list

So, intially it looks like index("ubuntu", "amazonLinux", ubuntu (current each.key iteration)). This yields zero because the first index
in our list where ubuntu is sitting is zero. 

When this get's completed then in the second iteration, it yields 1 as a index value.

Further code do mod

0 mod 2
1 mod 2

 */

  tags = {
    name = "${local.project}-TF-Server-For-Testing-one-${each.key}"
  }
}




