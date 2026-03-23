variable "ubuntu-amazonLinux-instances" {
  type = list(object ({
   ami = string
   instance_type = string
  }))
  /* default = [{
   ami = "ami-0c1ac8a41498c1a9c" // ubuntu ami id
   instance_type = "t2.micro"
  },
  {
   ami = "ami-0274f4b62b6ae3bd5"  // amazon linux ami id
   instance_type = "t2.micro"
  }
  ] */ 

  /* or instead of the above, you can use tf.vars to safely put the 
  the ami and fetch it over here. */
}

// amazon linux ami id : ami-0274f4b62b6ae3bd5
// ubuntu id : ami-0c1ac8a41498c1a9c



variable "ec2_map" {  // format is key-value pair for "map"
/* key= value where value is our object
having ami and instance_types */
  type = map(object({
    ami = string
    intance_type = string
  }))
}