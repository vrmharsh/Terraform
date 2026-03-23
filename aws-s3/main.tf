terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.89.0"
    }
    random = {
      source = "hashicorp/random"  // this has been copied from terraform registry website. Complete code is in random_id.tf
      version = "3.7.1"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "new_bucket" {  //aws_s3_bucket is resource type and then new_bucket is the name of the resource created.
// these resource types are unique in terraform
 bucket = "tf-test-bucket1025"

}

resource "aws_s3_object" "txt-file-upload" {  /* to upload anything, we need to use this resource type aws_s3_object. Everything that is uploaded in S3
is and object. Now this txt-file-upload is the name of this current resouce */
     
  bucket = aws_s3_bucket.new_bucket.bucket  /* here we are speifying the new object by the name bucket and that bucket consists of our
  resource type x resource name from the line 15. Because are the actual bucket resource consisting of the s3 bucket details.
  lastly we have .bucket over because this is representing the name of our bucket that is "tf-test-bucket1025" */
  source = "./test.txt"  // source of the file. Over here the name is test.txt file. Left side you will find it.
  key = "testUploadFile.txt"  // destination name of the file in s3 bucket. So, once uploaded, your file in s3 bucket will look like this.
}

