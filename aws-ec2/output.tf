output "aws_instance_public_ip"{  // this is by default name of an output block.
  value = aws_instance.My_TF_Web_Server.public_ip  

   /* 
   
    aws_instance is by default name
    My_TF_Web_Server is the name of the resource inside which you have created your instace. This is in your main.tf file
    and by .public_ip we are targetting the public ip of the instance.
    */
}