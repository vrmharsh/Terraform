/*  terraform {
  required_providers {
    random = {
      source = "hashicorp/random"      this is the completed piece of code. it is not needed since this has already been defined in main.tf under aws-s3 folder.
      version = "3.7.1"
    }
  }
} */


resource "random_id" "random_id_resource_name" {
  byte_length = 8            // meaning whatever id will be generated should have a byte length of 8.
}


resource "aws_s3_bucket" "Another_bucket" {  //aws_s3_bucket is resource type and then new_bucket is the name of the resource created.
// these resource types are unique in terraform
 bucket = "tf-test-bucket.${random_id.random_id_resource_name.hex}" // bucket name with the random id resource type and name. And hex over signifies that we want hexadecimal value of 8 bytes.

}

output "random_id_test_output" {
  value = random_id.random_id_resource_name.hex  // this is just to have the output of the randomly generated hexadecimal code in our terminal below. This value will be attached in the name of our bucket.
}

