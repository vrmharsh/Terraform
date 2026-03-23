resource "aws_instance" "nginxserver" { // here aws_instance is resource type and then we have the resource name
  ami = "ami-04b4f1a9cf54c11d0"  // ubuntu was selected so over their we were having the AMI ID. We haeve pasted the same thing over here. No need to type ubuntu and all.
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids =  [aws_security_group.nginx-sg.id] // here we are attaching that securtiy group over here.
  associate_public_ip_address = true  // in-order to access our instane over public network, we are saying that associate a public ip address with our EC2 instance so keeping the condition as true.

//Below code is to install nginx web server in your ec2 instance which will allow to host web services and application.
// EOF is end of file and in that we are writing our script.
  user_data = <<-EOF
            #!/bin/bash
            sudo yum install nginx -y
            sudo systemctl start nginx
            EOF


  tags = {
    Name = "NginxServer"
  }
}