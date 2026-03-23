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

/* Need to fetch the user's details from yaml file
which is "users.yaml" and use it to create IAM
users */

data "local_file" "config" {
  filename = "${path.module}/users.yaml"  // users.yaml will fetch the content of this file.
}

locals {
  config = yamldecode(data.local_file.config.content)   /* yamldecode is used to decode the file in a type of list. In users.yaml, 
  that file content is not in a form of list. */
} 

output "name" {
  value = local.config 
}

// The above was from google. Now let's write it in our own way.

locals {
    data = yamldecode(file("./users.yaml")).users 
}

output "yaml-file-content" {
  value = local.data[*].username
  /* to target only "username" from yaml file,
  we use ".username in this code." 
  [*] why this ?
  Because we want to have all the values of username
  from our yaml file
  */
}

resource "aws_iam_user" "IAM-Users" {
  for_each = toset(local.data[*].username)

  /* toset is in-built function make to list in
  a set form which removed duplicate entries
  and unordered list by chaning the list to 
  ordered set of list */
  name = each.value // [raju,sham,baburao], first iteration will give raju then sham and then baburao
}

/* Now we need to do password creation for the above
   users
 */


 resource "aws_iam_user_login_profile" "profile" { // specific to password creation of the users.
  # ... other configuration ...

  for_each = aws_iam_user.IAM-Users  // this will loop all the entres in IAM-Users
  user = each.value.name  /*
  why .name is used over here ?
  See, we pulled the "username" list from the above code which got stored in "name" as [raju, sham , baburao]
  Now, over you looped in all the users again by using "for-each", 
  So, iteration will run on all the "uername" entries which will get stored in "user". 
  It will be like [raju, sham , baburao].connection {
  But you need to target the firt entry and likewise other entries so that password can be given to all of them.
  So, we use .name which gets the itertation from the above code and first iteration gives "raju" and so this user get the password
  first.
  Likewise all the other get the password.
  Without .name, terraform wil pull the entire block of yaml file and will get confse to whom it should give the password.
  }
   */
   
  password_length = 8  // this will create password of 8 bits

  lifecycle { // this block is for the things which their name suggestes. 
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key, // 64 bit encoded key that gets associated with username
    ]
  }
}


output "password-for-IAM-Users" {
  value = aws_iam_user_login_profile.profile
  sensitive = true
}