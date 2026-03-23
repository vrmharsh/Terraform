
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

// below is vpc creation.
resource "aws_vpc" "my_tf_vpc" {
  cidr_block = "10.0.0.0/16"      // block of ip ranges  
  tags = {                
    name = "tf-test-vpc"          // name of your vpc
  }
}

// below is the private subnet for the above created vpc

resource "aws-subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"   // range of ip from the abve vpc cidr.
  vpc_id= aws_vpc.my_tf_vpc.id   // in aws whenever you are creating a subnet then you need to attach it to a vpc. So, here we are just attaching this private subnet to above created vpc. In aws, when you will create a subnet then their we need to give a vpc id to attach the subnet to vpc so here we are doing the same thing. This dot id means that we are specifying the id of that vpc.
  tags = {
    name = "tf-private-subnet"   // name of the private subnet
  }
}


// below is the public subnet for the above created vpc

resource "aws-subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id= aws_vpc.my_tf_vpc.id
  tags = {
    name = "tf-public-subnet"
  }
}

// now create internet gateway for any user coming from internet.

resource "aws_internet_gateway" "terraform-internetGateway" {
 tags = {    // this the "name tag" which you will find in every service so we are targetting that tag. And not the "Tags-optional" which are key-value and different in comparison to this.
    name = "terraform-igt"   // igt is gateway short form.
  }
  vpc_id= aws_vpc.my_tf_vpc.id
}

// now we create the routing tables which is very important to send traffic from one place to another.check "name" 
  
  resource "aws-routing-tables" "test-route-table" {
    tags = {
        name = "terraform-test-routes"
    }
    vpc_id= aws_vpc.my_tf_vpc.id
    route  {   // earlier euwal to that is = was used but that format is not correct so we have written it as route {}.
        cidr_block = "0.0.0.0/0"  // here we routed all the traffic to internet gateway.
        gateway_id = aws_internet_gateway.terraform-internetGateway.id  // forwarding everything towards above created gateway.
    }
  }

/* The above one includes all the traffic routed interet gateway. However, we have created private and public subnets and so we need to associate the above routes to those subnet associations
   In fact from AWS console also when you will create the routes then their is an option on right side to routes that is "subnet association" where you are specifying the subnet that you want to be associated with your "routes"
   The below are the resource for our "subnet associations".
 */

resource "aws_route_table_association" "subnet-public-association" {  
  route_table_id = aws-routing-tables.test-route-table.id  // here we have associated this  with the route table
  subnet_id = aws-subnet.public-subnet.id  // and also associated with the public subnet
}

