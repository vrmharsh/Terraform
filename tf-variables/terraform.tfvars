aws_instance_variable = "t2.micro"


ec2_config = {
volume_size = 30
volume_type = "gp3"
}


// over here we are giving the size and types of volume of our "ec2_config" which will be applied into "terraform.tfvars".

// So, this is a secure way to give the values via .tfvars.

// Our variables.tf code is expecting some values otherwise it will give default values. So, using this tfvars file, we are giving the values and this is an example of terraform variables.


additional_tags = {
  "DEPARTMENT" = "QA"
  "ENVIRONMENT" = "PROD"
}

/*  above additional tags you have given which will be applied to "additional tag" in variables.tf file. This will eventally be tagged
to the or say merge with tag in main.tf file. */

