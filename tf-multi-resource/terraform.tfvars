ubuntu-amazonLinux-instances = [   /* this name has to same as the variable so the the variable created in variables.tf know that 
we are targetting it */
    {
   ami = "ami-0c1ac8a41498c1a9c" // ubuntu ami id
   instance_type = "t2.micro"
  },
  {
   ami = "ami-0274f4b62b6ae3bd5"  // amazon linux ami id
   instance_type = "t2.micro"
  }
  ] 



  ec2_map = {  // we are  not using this [] but using this {} because we need to give key name then inside of it the values for ami id and instance type.
"ubuntu" = {
    ami = "ami-0c1ac8a41498c1a9c" 
    instance_type = "t2.micro"
},
    
"amazonLinux" = {
    ami = "ami-0274f4b62b6ae3bd5"  
    instance_type = "t2.micro"
}
  }
  
// key is ubuntu and values are AMI and INSTANCE_TYPE