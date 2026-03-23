variable "aws_instance_variable" {  // this is for t2.micro.This is fetched in "main.tf"
  description = "Type of instance like t2.micro or any other related types"
  type = string // we are expecting a string value over here.
  validation {
    condition = var.aws_instance_variable=="t2.micro" || var.aws_instance_variable=="t3.micro"
    error_message = "only t2 or t3 micro instance type allowed"
  }
}

/* above condition is meant to allow only t2 or t3 micro instance type. If someone gives any other value then the error_message will be displayed.
this will make sure that no one is creatig any large instance type which can cost a lot over here. */


variable "ec2_config" {
  type = object({   // over here we have combined two variables into one.
    volume_size= number  // this is size character of EBS where any user can give volume required.
    volume_type= string  // this is performance character of EBS where any user can give volume type as string.
  })

  default = {  // here we have given the default values imcase no user selects the volume type and size then below default values will be used.
    volume_size= 20
    volume_type="gp2"
  }
}

variable "additional_tags" {
  type = map (string)  // expecting a key-value pair. This is just an additional tags that we are having so that the tag in our main.tf does not merges with the tags for any other instances.
  default = {}  // by default we are keeping it empty.
}